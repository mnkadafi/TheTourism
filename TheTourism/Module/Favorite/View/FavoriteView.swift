//
//  FavoriteView.swift
//  TheTourism
//
//  Created by Mochamad Nurkhayal Kadafi on 10/12/20.
//

import SwiftUI
import Core
import Destination

struct FavoriteView: View {
  @ObservedObject var presenter: GetFavoritePresenter<
    Any, DestinationDomainModel, Interactor<
      Any, [DestinationDomainModel], GetFavoriteDestinationRepository<
        GetDestinationLocaleDataSource, GetDestinationRemoteDataSource, DestinationTransformer>>>
  
  var body: some View {
    ZStack {
      if presenter.isLoading {
        VStack {
          Text("Loading ...")
          ActivityIndicator()
        }
      } else {
        VStack {
          
          ScrollView(.vertical, showsIndicators: false) {
            if presenter.destinations.count == 0 {
              CustomInformationView(symbolName: "map.fill",
                                    text: "Saved destinations will be show up here.\n You haven't favorite destination")
            } else {
              SearchBar(text: $presenter.searchText, onSearchButtonClicked: presenter.searchByTitle)
              
              if self.presenter.filteredData.count == 0 {
                CustomInformationView(symbolName: "magnifyingglass.circle.fill",
                                      text: "No result for that keyword")
              } else {
                ForEach(self.presenter.filteredData, id: \.id) { destination in
                    ZStack {
                      FavoriteRouter().linkBuilder(for: destination) {
                        FavoriteRow(destination: destination)
                      }
                    }.buttonStyle(PlainButtonStyle())
                }.padding(.bottom, 0)
              }
            }
          }
        }
      }
    }.onAppear {
        self.presenter.getFavoriteDestination(request: nil)
    }.navigationBarTitle(
      Text("Favorite"),
      displayMode: .automatic
    )
  }
}
