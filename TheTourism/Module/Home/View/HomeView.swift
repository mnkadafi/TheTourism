//
//  HomeView.swift
//  TheTourism
//
//  Created by Mochamad Nurkhayal Kadafi on 10/12/20.
//

import SwiftUI
import Core
import Destination

public struct HomeView: View {
  @ObservedObject var presenter: GetListPresenter<
    Any, DestinationDomainModel, Interactor<
      Any, [DestinationDomainModel], GetDestinationRepository<
        GetDestinationLocaleDataSource, GetDestinationRemoteDataSource, DestinationTransformer>>>
//
//  let action: (() -> Destination)
//
//  public init(
//    presenterDes: GetListPresenter<
//      Any, DestinationDomainModel, Interactor<
//        Any, [DestinationDomainModel], GetDestinationRepository<
//          GetDestinationLocaleDataSource, GetDestinationRemoteDataSource, DestinationTransformer>>>,
//    action: @escaping (() -> Destination)
//  ) {
//    self.action = action
//    self.presenterDes = presenterDes
//  }
  
  public var body: some View {
    ZStack {
      if presenter.isLoading {
        loadingIndicator
      } else if presenter.isError {
        CustomInformationView(symbolName: "wifi.exclamationmark",
                              text: "Check your connection to see list destinations")
      } else if presenter.list.isEmpty {
        CustomInformationView(symbolName: "map.fill",
                              text: "List destinations are not available right now")
      } else {
        content
      }
    }.onAppear {
      if self.presenter.list.count == 0 {
        self.presenter.getList(request: nil)
      }
    }.navigationBarTitle(Text("The Tourism"), displayMode: .automatic)
  }
}

extension HomeView {

  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ActivityIndicator()
    }
  }
  
  var content: some View {
    ScrollView(.vertical, showsIndicators: false) {
      ForEach(
        self.presenter.list,
        id: \.id
      ) { destination in
        ZStack {
          HomeRouter().linkBuilder(for: destination) {
            DestinationRow(destination: destination)
          }
        }.buttonStyle(PlainButtonStyle())
      }
    }
  }
}
