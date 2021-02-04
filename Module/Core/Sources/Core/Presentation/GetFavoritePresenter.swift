//
//  SwiftUIView.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 10/01/21.
//

import SwiftUI
import Combine

public class GetFavoritePresenter<Request, Response, Interactor: UseCase>: ObservableObject
where Interactor.Request == Request, Interactor.Response == [Response] {
  private var cancellables: Set<AnyCancellable> = []
  private var publisher: AnyCancellable?
  private var _useCase: Interactor
  
  @Published public var destinations: [Response] = []
  @Published public var filteredData: [Response] = [Response]()
  @Published public var searchText = ""
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false
  
  var title = ""
  
  public init(useCase: Interactor) {
    _useCase = useCase
  }
  
  public func getFavoriteDestination(request: Request?) {
    isLoading = true
    _useCase.execute(request: nil)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { destinations in
        self.destinations = destinations
        self.filteredData = destinations
      }).store(in: &cancellables)
  }
  
  public func searchByTitle() {
    isLoading = true
    _useCase.execute(request: searchText as? Request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { destination in
        if !self.searchText.isEmpty {
          self.filteredData = destination
        } else {
          self.filteredData = self.destinations
        }
        
      }).store(in: &cancellables)
  }
  
}
