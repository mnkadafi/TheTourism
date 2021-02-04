//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 05/01/21.
//

import Core

public struct DetailDestinationTransformer: Mapper {
  
  public typealias Response = DestinationResponse
  public typealias Entity = DestinationModuleEntity
  public typealias Domain = DestinationDomainModel
  
  public init() {}
  
  public func transformResponseToEntity(response: DestinationResponse) -> DestinationModuleEntity {
    return DestinationModuleEntity()
  }
  
  public func transformEntityToDomain(entity: DestinationModuleEntity) -> DestinationDomainModel {
    return DestinationDomainModel(
      id: 0,
      name: "",
      description: "",
      address: "",
      longitude: 0,
      latitude: 0,
      like: 0,
      image: "",
      isFavorite: false)
  }
  
  public func transformEntityToDomainDetail(entity: DestinationModuleEntity) -> DestinationDomainModel {
    return DestinationDomainModel(
      id: entity.id,
      name: entity.name,
      description: entity.placeDescription,
      address: entity.address,
      longitude: entity.longitude,
      latitude: entity.latitude,
      like: entity.like,
      image: entity.image,
      isFavorite: entity.isFavorite
    )
  }
  
  public func transformDomainToEntities(domain: DestinationDomainModel) -> DestinationModuleEntity {
    let destination = DestinationModuleEntity()
    destination.id = domain.id
    destination.placeDescription = domain.placeDescription
    destination.address = domain.address
    destination.longitude = domain.longitude
    destination.latitude = domain.latitude
    destination.latitude = domain.latitude
    destination.like = domain.like
    destination.image = domain.image
    destination.isFavorite = domain.isFavorite
    return destination
  }
}
