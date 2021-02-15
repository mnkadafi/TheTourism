//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 25/01/21.
//

import Core

public struct UserTransformer: Mapper {
  
  public typealias Request = String
  public typealias Response = Any
  public typealias Entity = UserModuleEntity
  public typealias Domain = UserDomainModel
  
  public init() {}
  
  public func transformResponseToEntity(request: String?, response: Any) -> UserModuleEntity {
    fatalError()
  }
  
  public func transformEntityToDomain(entity: UserModuleEntity) -> UserDomainModel {
    return UserDomainModel(
      id: entity.id, name: entity.full_name,
      status: entity.status, bio: entity.bio,
      image: entity.image)
  }
  
  public func transformEntityToDomainDetail(entity: UserModuleEntity) -> UserDomainModel {
    fatalError()
  }
  
  public func transformDomainToEntities(domain: UserDomainModel) -> UserModuleEntity {
    fatalError()
  }
  
}
