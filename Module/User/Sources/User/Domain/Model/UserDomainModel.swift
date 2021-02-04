//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 25/01/21.
//

import Foundation

public struct UserDomainModel: Identifiable, Equatable {
  
  public let id: Int
  public let full_name: String
  public let status: String
  public let bio: String
  public let image: String
  
  public init(
    id: Int, name: String,
    status: String, bio: String, image: String) {
    
    self.id = id
    self.full_name = name
    self.status = status
    self.bio = bio
    self.image = image
  }
}
