//
//  FavoriteRouter.swift
//  TheTourism
//
//  Created by Mochamad Nurkhayal Kadafi on 10/12/20.
//

import SwiftUI
import Combine
import Core
import Destination

public class FavoriteRouter {
  
  func linkBuilder<Content: View>(
    for destination: DestinationDomainModel,
    @ViewBuilder content: () -> Content) -> some View {
    NavigationLink(
      destination: self.makeDetailView(for: destination)) {
      content()
    }
  }
  
  public func makeDetailView(for destination: DestinationDomainModel) -> some View {
    let destinationUseCase: Interactor<
      Any, DestinationDomainModel, GetDetailDestinationRepository<
          GetDestinationLocaleDataSource, GetDestinationRemoteDataSource, DetailDestinationTransformer>
            > = Injection.init().provideDetail()
    
    let presenter = GetDetailPresenter(useCase: destinationUseCase, detailDestination: destination)
    return DetailView(presenter: presenter)
  }
  
}
