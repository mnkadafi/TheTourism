//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 02/01/21.
//

import Core

public struct DestinationTransformer<DestinationMapper: Mapper>: Mapper
where
  DestinationMapper.Request == String,
  DestinationMapper.Response == DestinationResponse,
  DestinationMapper.Entity == DestinationModuleEntity,
  DestinationMapper.Domain == DestinationDomainModel {

  public typealias Request = String
  public typealias Response = [DestinationResponse]
  public typealias Entity = [DestinationModuleEntity]
  public typealias Domain = [DestinationDomainModel]
  
  private let _destinationMapper: DestinationMapper
  
  public init(destinationMapper: DestinationMapper) {
    _destinationMapper = destinationMapper
  }
  
  public func transformResponseToEntity(
    request: String?, response: [DestinationResponse])
  -> [DestinationModuleEntity] {
    return response.map { result in
      _destinationMapper.transformResponseToEntity(request: request, response: result)
    }
  }
  
  public func transformEntityToDomain(entity: [DestinationModuleEntity]) -> [DestinationDomainModel] {
    return entity.map { result in
      _destinationMapper.transformEntityToDomain(entity: result)
    }
  }
  
  public func transformDomainToEntities(domain: [DestinationDomainModel]) -> [DestinationModuleEntity] {
    fatalError()
  }
}
