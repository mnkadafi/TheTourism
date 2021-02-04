//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 02/01/21.
//

import Core

public struct DestinationTransformer: Mapper {
  
  public typealias Response = [DestinationResponse]
  public typealias Entity = [DestinationModuleEntity]
  public typealias Domain = [DestinationDomainModel]
  
  public init() {}
  
  public func transformResponseToEntity(response: [DestinationResponse]) -> [DestinationModuleEntity] {
    return response.map { result in
      let newDestination = DestinationModuleEntity()
      newDestination.id = result.id ?? 0
      newDestination.name = result.name ?? "Unknow"
      newDestination.placeDescription = result.placeDescription ?? "Unknow"
      newDestination.address = result.address ?? "Unknow"
      newDestination.longitude = result.longitude ?? 0
      newDestination.latitude = result.latitude ?? 0
      newDestination.like = result.like ?? 0
      newDestination.image = result.image ?? "Unknow"
      newDestination.isFavorite = false
      return newDestination
    }
  }
  
  public func transformEntityToDomain(entity: [DestinationModuleEntity]) -> [DestinationDomainModel] {
    return entity.map { result in
      return DestinationDomainModel(
        id: result.id,
        name: result.name,
        description: result.placeDescription,
        address: result.address,
        longitude: result.longitude,
        latitude: result.latitude,
        like: result.like,
        image: result.image,
        isFavorite: result.isFavorite
      )
    }
  }
  
  public func transformEntityToDomainDetail(entity: [DestinationModuleEntity]) -> [DestinationDomainModel] {
    return entity.map { _ in
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
  }
  
  public func transformDomainToEntities(domain: [DestinationDomainModel]) -> [DestinationModuleEntity] {
    fatalError()
  }
}
