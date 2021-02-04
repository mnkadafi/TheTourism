//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 25/01/21.
//

import Foundation
import RealmSwift

public class UserModuleEntity: Object {
  
  @objc dynamic var id: Int = 0
  @objc dynamic var full_name: String = ""
  @objc dynamic var status: String = ""
  @objc dynamic var bio: String = ""
  @objc dynamic var image: String = ""
  
  public override static func primaryKey() -> String? {
    return "id"
  }
  
}
