//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 31/12/20.
//

import Foundation
import RealmSwift

public class DestinationModuleEntity: Object {
  
  @objc dynamic var id: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var placeDescription: String = ""
  @objc dynamic var address: String = ""
  @objc dynamic var longitude: Double = 0
  @objc dynamic var latitude: Double = 0
  @objc dynamic var like: Int = 0
  @objc dynamic var image: String = ""
  @objc dynamic var isFavorite: Bool = false
  
  public override static func primaryKey() -> String? {
    return "id"
  }
  
}
