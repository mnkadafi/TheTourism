//
//  Injection.swift
//  TheTourism
//
//  Created by Mochamad Nurkhayal Kadafi on 10/12/20.
//

import Foundation
import RealmSwift
import Core
import Destination
import User
import UIKit

final class Injection: NSObject {
  
  func provideDestination<U: UseCase>() -> U
  where U.Request == Any, U.Response == [DestinationDomainModel] {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let locale = GetDestinationLocaleDataSource(realm: appDelegate!.realm)
    let remote = GetDestinationRemoteDataSource(endpoint: Endpoints.Gets.list.url)
    let mapper = DestinationTransformer()
    
    let repository = GetDestinationRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)
    
    return (Interactor(repository: repository) as? U)!
  }
  
  func provideDetail<U: UseCase>() -> U
  where U.Request == Any, U.Response == DestinationDomainModel {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let locale = GetDestinationLocaleDataSource(realm: appDelegate!.realm)
    let remote = GetDestinationRemoteDataSource(endpoint: "")
    let mapper = DetailDestinationTransformer()
    
    let repository = GetDetailDestinationRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)
    
    return (Interactor(repository: repository) as? U)!
  }
  
  func provideFavorite<U: UseCase>() -> U
  where U.Request == Any, U.Response == [DestinationDomainModel] {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let locale = GetDestinationLocaleDataSource(realm: appDelegate!.realm)
    let remote = GetDestinationRemoteDataSource(endpoint: "")
    let mapper = DestinationTransformer()
    
    let repository = GetFavoriteDestinationRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)
    
    return (Interactor(repository: repository) as? U)!
  }
  
  func provideProfile<U: UseCase>() -> U
  where U.Request == Any, U.Response == UserDomainModel {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let locale = GetUserLocaleDataSource(realm: appDelegate!.realm)
    let mapper = UserTransformer()
    
    let repository = GetUserRepository(
      localeDataSource: locale,
      mapper: mapper)
    
    return (Interactor(repository: repository) as? U)!
  }
  
}
