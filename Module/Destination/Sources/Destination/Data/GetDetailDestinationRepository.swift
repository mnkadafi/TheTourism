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
  DestinationLocalDataSource.Request == String,
  DestinationLocalDataSource.Response == DestinationModuleEntity,
  RemoteDataSource.Request == String,
  RemoteDataSource.Response == DestinationResponse,
  Transofrmer.Request == String,
  Transofrmer.Response == DestinationResponse,
  Transofrmer.Entity == DestinationModuleEntity,
  Transofrmer.Domain == DestinationDomainModel {
  
  public typealias Request = String
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
  
  public func execute(request: String?) -> AnyPublisher<DestinationDomainModel, Error> {
    print("\(request) KASMKMASKMSA")
    guard let request = request else { fatalError("Request cannot be empty") }
    
    return _localeDataSource.get(request: request)
      .map { _mapper.transformEntityToDomain(entity: $0) }
      .eraseToAnyPublisher()
  }
}
