//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 25/01/21.
//

import Core
import Combine
import RealmSwift
import Foundation
import UIKit

public struct GetUserLocaleDataSource: UserLocaleDataSource {
  
  public typealias Request = Any
  public typealias Response = UserModuleEntity
  
  private let _realm: Realm?
  
  public init(realm: Realm?) {
    _realm = realm
  }
  
  public func getUser(request: Any?) -> AnyPublisher<UserModuleEntity, Error> {
    return Future<UserModuleEntity, Error> { completion in
      let user: Results<UserModuleEntity> = {
        _realm!.objects(UserModuleEntity.self)
      }()
      
      if user.isEmpty {
        let userDummy = UserModuleEntity()
        userDummy.id = 1
        userDummy.full_name = "Mochamad Nurkhayal Kadafi"
        userDummy.status = "Mahasiswa"
        userDummy.bio = """
          Adalah seorang mahasiswa dari salah satu Universitas di Kota Bandung. \
          Diperkirakan memulai menjadi seorang iOS Developer pada akhir tahun 2019 \
          karena tuntutan sebuah divisi di kampus. Senang bisa mencoba menjadi seorang iOS Developer.
          """
        userDummy.image = "pp"
        
        do {
          try _realm!.write {
            _realm!.add(userDummy)
          }
        } catch {
          fatalError()
        }
        
        let userDummys: Results<UserModuleEntity> = {
            _realm!.objects(UserModuleEntity.self)
          }()
        completion(.success(userDummys.getResult(selectedType: UserModuleEntity.self)!))
      } else {
        completion(.success(user.getResult(selectedType: UserModuleEntity.self)!))
      }
    }.eraseToAnyPublisher()
  }
  
  public func addUser(entities: UserModuleEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try _realm!.write {
          _realm!.add(entities, update: .all)
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }
}
