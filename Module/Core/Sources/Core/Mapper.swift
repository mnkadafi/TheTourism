//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 30/12/20.
//

import Foundation

public protocol Mapper {
  associatedtype Request
  associatedtype Response
  associatedtype Entity
  associatedtype Domain
  
  func transformResponseToEntity(request: Request?, response: Response) -> Entity
  func transformEntityToDomain(entity: Entity) -> Domain
  func transformDomainToEntities(domain: Domain) -> Entity
}
