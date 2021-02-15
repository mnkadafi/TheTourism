//
//  HomeRouter.swift
//  TheTourism
//
//  Created by Mochamad Nurkhayal Kadafi on 10/12/20.
//

import SwiftUI
import Combine
import Core
import Destination

public class HomeRouter {
  
  public func makeDetailView(for destination: DestinationDomainModel) -> some View {
    let destinationUseCase: Interactor<
      String, DestinationDomainModel, GetDetailDestinationRepository<
          GetDestinationLocaleDataSource, GetDetailDestinationRemoteDataSource, DetailDestinationTransformer>
            > = Injection.init().provideDetail()
    
    let favoriteUseCase: Interactor<
      String, DestinationDomainModel, UpdateFavoriteDestinationRepository<
          FavoriteDestinationLocaleDataSource, DetailDestinationTransformer>
            > = Injection.init().provideUpdateFavorite()
    
    let presenter = GetDetailPresenter(detailDestinationUseCase: destinationUseCase, favoriteUseCase: favoriteUseCase)
    
    return DetailView(presenter: presenter, destination: destination)
  }
}
