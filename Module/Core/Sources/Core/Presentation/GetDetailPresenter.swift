//
//  SwiftUIView.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 05/01/21.
//

import SwiftUI
import Combine

public class GetDetailPresenter<Request, Response, Interactor: UseCase>: ObservableObject
where Interactor.Request == Request, Interactor.Response == Response {
  private var cancellables: Set<AnyCancellable> = []

  private var _useCase: Interactor
  
  @Published public var detailDestination: Response?
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false
  @Published public var isFavorite: Bool = false
  @Published public var isSaved: Bool = false
  @Published public var isRemoved: Bool = false
  
  public init(useCase: Interactor, detailDestination: Response?) {
    _useCase = useCase
    
    self.detailDestination = detailDestination
  }
  
  public func getDetail() {
    isLoading = true
    _useCase.execute(request: nil)
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
        self.detailDestination = destination
      })
      .store(in: &cancellables)
  }
  
  public func isFavoriteDestination(request: Request) {
    _useCase.execute_two(request: request, useInfo: 0)
    .receive(on: RunLoop.main)
    .sink(receiveCompletion: { completion in
      switch completion {
      case .failure:
        self.errorMessage = String(describing: completion)
      case .finished:
        self.isLoading = false
      }
    }, receiveValue: { result in
      self.isFavorite = result
    }).store(in: &cancellables)
  }
  
  public func addToFavoriteDestination(request: Request) {
    _useCase.execute_two(request: request, useInfo: 1)
    .receive(on: RunLoop.main)
    .sink(receiveCompletion: { completion in
      switch completion {
      case .failure:
        self.errorMessage = String(describing: completion)
      case .finished:
        self.isLoading = false
      }
    }, receiveValue: { result in
      self.isSaved = result
    }).store(in: &cancellables)
  }
  
  public func removeFavoriteDestination(request: Request) {
    _useCase.execute_two(request: request, useInfo: 2)
    .receive(on: RunLoop.main)
    .sink(receiveCompletion: { completion in
      switch completion {
      case .failure:
        self.errorMessage = String(describing: completion)
      case .finished:
        self.isLoading = false
      }
    }, receiveValue: { result in
      self.isRemoved = result
    }).store(in: &cancellables)
  }
  
}
