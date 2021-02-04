//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 02/01/21.
//

import Foundation

public struct DestinationsResponse: Decodable {
  
  let places: [DestinationResponse]
  
}

public struct DestinationResponse: Decodable {
  
  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case placeDescription = "description"
    case address
    case longitude
    case latitude
    case like
    case image
  }
  
  let id: Int?
  let name: String?
  let placeDescription: String?
  let address: String?
  let longitude, latitude: Double?
  let like: Int?
  let image: String?
  
}
