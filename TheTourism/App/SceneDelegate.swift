//
//  SceneDelegate.swift
//  TheTourism
//
//  Created by Mochamad Nurkhayal Kadafi on 10/12/20.
//

import UIKit
import SwiftUI
import RealmSwift
import Core
import Destination
import User

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions
  ) {

    let injection = Injection()
    
    let destinationUseCase: Interactor<
      String,
      [DestinationDomainModel],
      GetDestinationRepository<
        GetDestinationLocaleDataSource,
        GetDestinationRemoteDataSource,
        DestinationTransformer<DetailDestinationTransformer>>>
          = injection.provideDestination()
    
    let favoriteUseCase: Interactor<
      String,
      [DestinationDomainModel],
      GetFavoriteDestinationRepository<
        FavoriteDestinationLocaleDataSource,
        DestinationTransformer<DetailDestinationTransformer>>>
          = injection.provideFavorite()
    
    let profileUseCase: Interactor<
      Any, UserDomainModel, GetUserRepository<
        GetUserLocaleDataSource,
        UserTransformer>> = injection.provideProfile()
    
    let homePresenter = GetListPresenter(useCase: destinationUseCase)
    let favoritePresenter = GetFavoritePresenter(useCase: favoriteUseCase)
    let profilePresenter = GetUserPresenter(useCase: profileUseCase)

    let contentView = ContentView()
      .environmentObject(homePresenter)
      .environmentObject(favoritePresenter)
      .environmentObject(profilePresenter)

    if let windowScene = scene as? UIWindowScene {
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: contentView)
        self.window = window
        window.makeKeyAndVisible()
    }
  }

}
