//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 02/01/21.
//

import Foundation

public struct DestinationDomainModel: Equatable, Identifiable {
  
  public let id: Int
  public let name: String
  public let placeDescription: String
  public let address: String
  public let longitude: Double
  public let latitude: Double
  public let like: Int
  public let image: String
  public let isFavorite: Bool
  
  public init(
    id: Int, name: String,
    description: String, address: String,
    longitude: Double, latitude: Double,
    like: Int, image: String, isFavorite: Bool) {
    
    self.id = id
    self.name = name
    self.placeDescription = description
    self.address = address
    self.longitude = longitude
    self.latitude = latitude
    self.like = like
    self.image = image
    self.isFavorite = isFavorite
  }
}
