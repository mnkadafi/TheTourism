//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 11/01/21.
//

import Core
import Combine

public struct GetFavoriteDestinationRepository<
  DestinationLocalDataSource: LocaleDataSource,
  RemoteDataSource: DataSource,
  Transofrmer: Mapper>: Repository
where
  DestinationLocalDataSource.Response == DestinationModuleEntity,
  RemoteDataSource.Response == [DestinationResponse],
  Transofrmer.Response == [DestinationResponse],
  Transofrmer.Entity == [DestinationModuleEntity],
  Transofrmer.Domain == [DestinationDomainModel] {
  
  public typealias Request = Any
  public typealias Response = [DestinationDomainModel]
  
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
  
  public func execute(request: Any?) -> AnyPublisher<[DestinationDomainModel], Error> {
    if request != nil {
      return _localeDataSource.searchFavoriteByTitle(title: (request as? String)!)
        .map { _mapper.transformEntityToDomain(entity: $0) }
        .eraseToAnyPublisher()
    } else {
      return _localeDataSource.getFavoriteList(request: nil)
        .map { _mapper.transformEntityToDomain(entity: $0) }
        .eraseToAnyPublisher()
    }
  }
  
  public func execute_two(request: Any?, useInfo: Int?) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
}
