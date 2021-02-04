//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 05/01/21.
//

import Core
import Combine

public struct GetDetailDestinationRepository<
  DestinationLocalDataSource: LocaleDataSource,
  RemoteDataSource: DataSource,
  Transofrmer: Mapper>: Repository
where
  DestinationLocalDataSource.Response == DestinationModuleEntity,
  RemoteDataSource.Response == [DestinationResponse],
  Transofrmer.Response == DestinationResponse,
  Transofrmer.Entity == DestinationModuleEntity,
  Transofrmer.Domain == DestinationDomainModel {
  
  public typealias Request = Any
  public typealias Response = DestinationDomainModel
  
  private let _localeDataSource: DestinationLocalDataSource
  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transofrmer
  
  public init(
    localeDataSource: DestinationLocalDataSource,
    remoteDataSource: RemoteDataSource,
    mapper: Transofrmer) {
    
    _localeDataSource = localeDataSource
    _remoteDataSource = remoteDataSource
    _mapper = mapper
  }
  
  public func execute(request: Any?) -> AnyPublisher<DestinationDomainModel, Error> {
    return _localeDataSource.getDetailDestination(request: (request as? Int))
        .map { _mapper.transformEntityToDomainDetail(entity: $0)}
        .eraseToAnyPublisher()
  }
  
  public func execute_two(request: Any?, useInfo: Int?) -> AnyPublisher<Bool, Error> {
    let dataMapper = _mapper.transformDomainToEntities(domain: (request as? DestinationDomainModel)!)
    if useInfo == 0 {
      return _localeDataSource.isFavoriteDestination(entity: dataMapper)
        .eraseToAnyPublisher()
    } else if useInfo == 1 {
      return _localeDataSource.addToFavoriteDestination(entity: dataMapper)
        .eraseToAnyPublisher()
    } else {
      return _localeDataSource.removeFavoriteDestination(entity: dataMapper)
        .eraseToAnyPublisher()
    }
  }
}
