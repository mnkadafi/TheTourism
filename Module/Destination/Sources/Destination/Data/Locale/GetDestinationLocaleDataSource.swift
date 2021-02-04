//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 31/12/20.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetDestinationLocaleDataSource: LocaleDataSource {
  
  public typealias Request = Any
  public typealias Response = DestinationModuleEntity
  
  private let _realm: Realm?
  
  public init(realm: Realm) {
    _realm = realm
  }
  
  public func getListDestination(request: Any?) -> AnyPublisher<[DestinationModuleEntity], Error> {
    return Future<[DestinationModuleEntity], Error> { completion in
      let destination: Results<DestinationModuleEntity> = {
        _realm!.objects(DestinationModuleEntity.self)
          .sorted(byKeyPath: "name", ascending: true)
      }()
      completion(.success(destination.toArray(ofType: DestinationModuleEntity.self)))
    }.eraseToAnyPublisher()
  }
  
  public func addListDestination(entities: [DestinationModuleEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try _realm!.write {
          for destination in entities {
            _realm!.add(destination, update: .all)
          }
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }
  
  public func getDetailDestination(request: Int?) -> AnyPublisher<DestinationModuleEntity, Error> {
    return Future<DestinationModuleEntity, Error> { completion in
      if let realm = self._realm {
        let destinationDetail: Results<DestinationModuleEntity> = {
          realm.objects(DestinationModuleEntity.self)
            .filter("id == \(request!)")
        }()
        completion(.success(destinationDetail.getResult(selectedType: DestinationModuleEntity.self)!))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func getFavoriteList(request: Any?) -> AnyPublisher<[DestinationModuleEntity], Error> {
    return Future<[DestinationModuleEntity], Error> { completion in
      let favoriteDestination: Results<DestinationModuleEntity> = {
        _realm!.objects(DestinationModuleEntity.self)
          .filter("isFavorite == true")
          .sorted(byKeyPath: "name", ascending: true)
      }()
      completion(.success(favoriteDestination.toArray(ofType: DestinationModuleEntity.self)))
    }.eraseToAnyPublisher()
  }
  
  public func searchFavoriteByTitle(title: String) -> AnyPublisher<[DestinationModuleEntity], Error> {
    return Future<[DestinationModuleEntity], Error> { completion in
      let favoriteDestination: Results<DestinationModuleEntity> = {
        _realm!.objects(DestinationModuleEntity.self)
          .filter("name contains[c] %@ AND isFavorite == true", title)
          .sorted(byKeyPath: "name", ascending: true)
      }()
      completion(.success(favoriteDestination.toArray(ofType: DestinationModuleEntity.self)))
    }.eraseToAnyPublisher()
  }
  
  public func isFavoriteDestination(entity: DestinationModuleEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self._realm {
        let isFavorite = realm.objects(DestinationModuleEntity.self)
          .filter("id == \(entity.id) AND isFavorite == 1")
        if isFavorite.count == 1 {
          completion(.success(true))
        } else {
          completion(.success(false))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func addToFavoriteDestination(entity: DestinationModuleEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self._realm {
        do {
          let favoriteData = realm.objects(DestinationModuleEntity.self).filter("id == \(entity.id)").first
          try realm.write {
            favoriteData?.isFavorite = true
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func removeFavoriteDestination(entity: DestinationModuleEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self._realm {
        do {
          let favoriteData = realm.objects(DestinationModuleEntity.self).filter("id == \(entity.id)").first
          try realm.write {
            favoriteData?.isFavorite = false
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
}
