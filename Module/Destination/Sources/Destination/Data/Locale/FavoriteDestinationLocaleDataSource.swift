//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 10/02/21.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct FavoriteDestinationLocaleDataSource: LocaleDataSource {
  
  public typealias Request = String
  public typealias Response = DestinationModuleEntity
  
  private let _realm: Realm
  
  public init(realm: Realm) {
    _realm = realm
  }
  
  public func list(request: String?) -> AnyPublisher<[DestinationModuleEntity], Error> {
    return Future<[DestinationModuleEntity], Error> { completion in
      let favoriteDestination: Results<DestinationModuleEntity> = {
        _realm.objects(DestinationModuleEntity.self)
          .filter("isFavorite == \(true)")
          .sorted(byKeyPath: "name", ascending: true)
      }()
      completion(.success(favoriteDestination.toArray(ofType: DestinationModuleEntity.self)))
    }.eraseToAnyPublisher()
  }
  
  public func add(entities: [DestinationModuleEntity]) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
  public func get(request: String) -> AnyPublisher<DestinationModuleEntity, Error> {
    return Future<DestinationModuleEntity, Error> { completion in
      if let favoriteData = {
        _realm.objects(DestinationModuleEntity.self).filter("id == '\(request)'")
      }().first {
        do {
          try _realm.write {
            favoriteData.setValue(!favoriteData.isFavorite, forKey: "isFavorite")
          }
          completion(.success(favoriteData))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func update(id: String?, entity: DestinationModuleEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
  public func search(title: String) -> AnyPublisher<[DestinationModuleEntity], Error> {
    return Future<[DestinationModuleEntity], Error> { completion in
      let favoriteDestination: Results<DestinationModuleEntity> = {
        _realm.objects(DestinationModuleEntity.self)
          .filter("name contains[c] %@ AND isFavorite == true", title)
          .sorted(byKeyPath: "name", ascending: true)
      }()
      completion(.success(favoriteDestination.toArray(ofType: DestinationModuleEntity.self)))
    }.eraseToAnyPublisher()
  }
}
