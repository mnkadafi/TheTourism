//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 30/12/20.
//

import Foundation

public protocol Mapper {
  associatedtype Response
  associatedtype Entity
  associatedtype Domain
  
  func transformResponseToEntity(response: Response) -> Entity
  func transformEntityToDomain(entity: Entity) -> Domain
  func transformEntityToDomainDetail(entity: Entity) -> Domain
  func transformDomainToEntities(domain: Domain) -> Entity
}
