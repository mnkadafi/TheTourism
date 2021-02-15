//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 05/01/21.
//

import Core

public struct DetailDestinationTransformer: Mapper {

  public typealias Request = String
  public typealias Response = DestinationResponse
  public typealias Entity = DestinationModuleEntity
  public typealias Domain = DestinationDomainModel
  
  public init() {}
  
  public func transformResponseToEntity(request: String?, response: DestinationResponse) -> DestinationModuleEntity {
    
      let newDestination = DestinationModuleEntity()
    
      newDestination.id = String(response.id!)
      newDestination.name = response.name ?? "Unknow"
      newDestination.placeDescription = response.placeDescription ?? "Unknow"
      newDestination.address = response.address ?? "Unknow"
      newDestination.longitude = response.longitude ?? 0
      newDestination.latitude = response.latitude ?? 0
      newDestination.like = response.like ?? 0
      newDestination.image = response.image ?? "Unknow"
      newDestination.isFavorite = false
    
      return newDestination
  }
  
  public func transformEntityToDomain(entity: DestinationModuleEntity) -> DestinationDomainModel {
    return DestinationDomainModel(
      id: String(entity.id),
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
  
  public func transformEntityToDomainDetail(entity: DestinationModuleEntity) -> DestinationDomainModel {
    return DestinationDomainModel(
      id: String(entity.id),
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
