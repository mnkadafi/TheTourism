//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 10/02/21.
//

import Core
import Combine

public struct UpdateFavoriteDestinationRepository<
  DestinationLocaleDataSource: LocaleDataSource,
  Transformer: Mapper>: Repository
where
  DestinationLocaleDataSource.Request == String,
  DestinationLocaleDataSource.Response == DestinationModuleEntity,
  Transformer.Request == String,
  Transformer.Response == DestinationResponse,
  Transformer.Entity == DestinationModuleEntity,
  Transformer.Domain == DestinationDomainModel {
  
  public typealias Request = String
  public typealias Response = DestinationDomainModel
  
  private let _localeDataSource: DestinationLocaleDataSource
  private let _mapper: Transformer
  
  public init(
    localeDataSource: DestinationLocaleDataSource,
    mapper: Transformer) {
    
    _localeDataSource = localeDataSource
    _mapper = mapper
  }
    
  public func execute(request: String?) -> AnyPublisher<DestinationDomainModel, Error> {
    return _localeDataSource.get(request: request!)
      .map { _mapper.transformEntityToDomain(entity: $0) }
      .eraseToAnyPublisher()
  }
}
