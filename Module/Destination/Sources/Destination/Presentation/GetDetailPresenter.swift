//
//  SwiftUIView.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 12/02/21.
//

import SwiftUI
import Combine
import Core

public class GetDetailPresenter<DetailDestinationUseCase: UseCase, FavoriteUseCase: UseCase>: ObservableObject
where
  DetailDestinationUseCase.Request == String, DetailDestinationUseCase.Response == DestinationDomainModel,
  FavoriteUseCase.Request == String, FavoriteUseCase.Response == DestinationDomainModel {
  
  private var cancellables: Set<AnyCancellable> = []

  private var _detailDestinationUseCase: DetailDestinationUseCase
  private var _favoriteDestinationUseCase: FavoriteUseCase
  
  @Published public var detailDestination: DestinationDomainModel?
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false
  
  public init(detailDestinationUseCase: DetailDestinationUseCase, favoriteUseCase: FavoriteUseCase) {
    _detailDestinationUseCase = detailDestinationUseCase
    _favoriteDestinationUseCase = favoriteUseCase
  }
  
  public func getDetail(request: DetailDestinationUseCase.Request) {
    isLoading = true
    _detailDestinationUseCase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { destination in
        print("\(destination) HASIL MAPPER")
        self.detailDestination = destination
      })
      .store(in: &cancellables)
  }
  
  public func updateFavoriteDestination(request: DetailDestinationUseCase.Request) {
    _favoriteDestinationUseCase.execute(request: request)
    .receive(on: RunLoop.main)
    .sink(receiveCompletion: { completion in
      switch completion {
      case .failure:
        self.errorMessage = String(describing: completion)
      case .finished:
        self.isLoading = false
      }
    }, receiveValue: { result in
      self.detailDestination = result
    }).store(in: &cancellables)
  }
  
}
