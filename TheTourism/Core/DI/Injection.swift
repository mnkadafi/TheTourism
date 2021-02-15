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
  where U.Request == String, U.Response == [DestinationDomainModel] {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let locale = GetDestinationLocaleDataSource(realm: appDelegate!.realm)
    let remote = GetDestinationRemoteDataSource(endpoint: Endpoints.Gets.list.url)
    
    let destinationMapper = DetailDestinationTransformer()
    let mapper = DestinationTransformer(destinationMapper: destinationMapper)
    
    let repository = GetDestinationRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)
    
    return (Interactor(repository: repository) as? U)!
  }
  
  func provideDetail<U: UseCase>() -> U
  where U.Request == String, U.Response == DestinationDomainModel {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let locale = GetDestinationLocaleDataSource(realm: appDelegate!.realm)
    let remote = GetDetailDestinationRemoteDataSource(endpoint: "")
    
    let mapper = DetailDestinationTransformer()
    
    let repository = GetDetailDestinationRepository(
      localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
    
    return (Interactor(repository: repository) as? U)!
  }
  
  func provideFavorite<U: UseCase>() -> U
  where U.Request == String, U.Response == [DestinationDomainModel] {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let locale = FavoriteDestinationLocaleDataSource(realm: appDelegate!.realm)
    
    let destinationMapper = DetailDestinationTransformer()
    let mapper = DestinationTransformer(destinationMapper: destinationMapper)
    
    let repository = GetFavoriteDestinationRepository(
      localeDataSource: locale,
      mapper: mapper)
    
    return (Interactor(repository: repository) as? U)!
  }
  
  func provideUpdateFavorite<U: UseCase>() -> U
  where U.Request == String, U.Response == DestinationDomainModel {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let locale = FavoriteDestinationLocaleDataSource(realm: appDelegate!.realm)
    
    let mapper = DetailDestinationTransformer()
    
    let repository = UpdateFavoriteDestinationRepository(
      localeDataSource: locale,
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
