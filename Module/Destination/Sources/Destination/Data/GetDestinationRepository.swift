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
    return _localeDataSource.getListDestination(request: nil)
      .flatMap { result -> AnyPublisher<[DestinationDomainModel], Error> in
        if result.isEmpty {
          return _remoteDataSource.execute(request: nil)
            .map { _mapper.transformResponseToEntity(response: $0) }
            .catch { _ in _localeDataSource.getListDestination(request: nil) }
            .flatMap { _localeDataSource.addListDestination(entities: $0) }
            .filter { $0 }
            .flatMap { _ in _localeDataSource.getListDestination(request: nil)
              .map { _mapper.transformEntityToDomain(entity: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return _localeDataSource.getListDestination(request: nil)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
  public func execute_two(request: Any?, useInfo: Int?) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
}
