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
  Transofrmer: Mapper>: Repository
where
  DestinationLocalDataSource.Request == String,
  DestinationLocalDataSource.Response == DestinationModuleEntity,
  Transofrmer.Request == String,
  Transofrmer.Response == [DestinationResponse],
  Transofrmer.Entity == [DestinationModuleEntity],
  Transofrmer.Domain == [DestinationDomainModel] {
  
  public typealias Request = String
  public typealias Response = [DestinationDomainModel]
  
  private let _localeDataSource: DestinationLocalDataSource
  private let _mapper: Transofrmer
  
  public init(
    localeDataSource: DestinationLocalDataSource,
    mapper: Transofrmer) {
    
    _localeDataSource = localeDataSource
    _mapper = mapper
  }
  
  public func execute(request: String?) -> AnyPublisher<[DestinationDomainModel], Error> {
    if request != nil {
      return _localeDataSource.search(title: request!)
        .map { _mapper.transformEntityToDomain(entity: $0) }
        .eraseToAnyPublisher()
    } else {
      return _localeDataSource.list(request: nil)
        .map { _mapper.transformEntityToDomain(entity: $0) }
        .eraseToAnyPublisher()
    }
  }
}
