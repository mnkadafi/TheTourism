//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 30/12/20.
//

import Foundation
import RealmSwift

extension Results {
  
  public func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0..<count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
  
  public func getResult<T: Object>(selectedType: T.Type) -> T? {
    return realm?.objects(selectedType).first
  }
  
}
