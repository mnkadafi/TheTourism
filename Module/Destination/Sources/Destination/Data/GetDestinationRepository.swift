//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 02/01/21.
//

import Core
import Combine

public struct GetDestinationRepository<
  DestinationLocalDataSource: LocaleDataSource,
  RemoteDataSource: DataSource,
  Transofrmer: Mapper>: Repository
where
  DestinationLocalDataSource.Request == String,
  DestinationLocalDataSource.Response == DestinationModuleEntity,
  RemoteDataSource.Request == String,
  RemoteDataSource.Response == [DestinationResponse],
  Transofrmer.Request == String,
  Transofrmer.Response == [DestinationResponse],
  Transofrmer.Entity == [DestinationModuleEntity],
  Transofrmer.Domain == [DestinationDomainModel] {
  
  public typealias Request = String
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
  
  public func execute(request: String?) -> AnyPublisher<[DestinationDomainModel], Error> {
    return _localeDataSource.list(request: request)
      .flatMap { result -> AnyPublisher<[DestinationDomainModel], Error> in
        if result.isEmpty {
          return _remoteDataSource.execute(request: request)
            .map { _mapper.transformResponseToEntity(request: request, response: $0) }
            .catch { _ in _localeDataSource.list(request: request) }
            .flatMap { _localeDataSource.add(entities: $0) }
            .filter { $0 }
            .flatMap { _ in _localeDataSource.list(request: nil)
              .map { _mapper.transformEntityToDomain(entity: $0) }
            }.eraseToAnyPublisher()
        } else {
          return _localeDataSource.list(request: nil)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
}
