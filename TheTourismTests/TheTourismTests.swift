//
//  TheTourismTests.swift
//  TheTourismTests
//
//  Created by Mochamad Nurkhayal Kadafi on 10/12/20.
//

import XCTest
@testable import TheTourism

class TheTourismTests: XCTestCase {
  
  public struct DestinationDomainModel: Identifiable {
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
  
  var destinations = [DestinationDomainModel]()
  
  func testInvalidInputDestination() {
    XCTAssertThrowsError(
      try detectInformationDestination(
        id: 1, name: "Alun-Alun Bandung", address: "Kota Bandung", like: 100)) { error in
      XCTAssertEqual(error as? DestinationErrorType, DestinationErrorType.invalidInput)
    }
  }
  
  func detectInformationDestination(
    id: Int, name: String, address: String, like: Int) throws {
    
  }
  
}

enum DestinationErrorType: Error {
  case invalidInput
}
