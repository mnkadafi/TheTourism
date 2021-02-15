//
//  ContentView.swift
//  TheTourism
//
//  Created by Mochamad Nurkhayal Kadafi on 10/12/20.
//

import SwiftUI
import Core
import Destination
import User
import RealmSwift

struct ContentView: View {
  
  @EnvironmentObject var homePresenter: GetListPresenter<
    String, DestinationDomainModel, Interactor<
      String, [DestinationDomainModel], GetDestinationRepository<
        GetDestinationLocaleDataSource, GetDestinationRemoteDataSource,
        DestinationTransformer<DetailDestinationTransformer>>>>
  @EnvironmentObject var favoritePresenter: GetFavoritePresenter<
    String, DestinationDomainModel, Interactor<
      String, [DestinationDomainModel], GetFavoriteDestinationRepository<
        FavoriteDestinationLocaleDataSource,
        DestinationTransformer<DetailDestinationTransformer>>>>
  @EnvironmentObject var profilePresenter: GetUserPresenter<
    Any, UserDomainModel, Interactor<
      Any, UserDomainModel, GetUserRepository<
        GetUserLocaleDataSource, UserTransformer>>>
  
  @State var tabSelection: Tabs = .home
  
  var body: some View {
    ZStack {
      TabView(selection: $tabSelection) {
        NavigationView {
          HomeView(presenter: homePresenter)
        }.tabItem {
          Image(systemName: "house.fill")
          Text("Home")
        }.tag(Tabs.home)
        
        NavigationView {
          FavoriteView(presenter: favoritePresenter)
        }.tabItem {
          Image(systemName: "heart.fill")
          Text("Favorite")
        }.tag(Tabs.favorite)
        
        NavigationView {
          ProfileView(presenter: profilePresenter)
        }.tabItem {
          Image(systemName: "person.fill")
          Text("Profile")
        }.tag(Tabs.profile)
      }
      .navigationBarTitle(returnNaviBarTitle(tabSelection: self.tabSelection))
      .accentColor(.black)
    }
  }
  
  enum Tabs {
    case home, favorite, profile
  }
  
  func returnNaviBarTitle(tabSelection: Tabs) -> String {
    switch tabSelection {
    case .home:
      return "Tourism Apps"
    case .favorite:
      return "Favorite"
    case .profile:
      return ""
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
