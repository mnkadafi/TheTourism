//
//  SwiftUIView.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 25/01/21.
//

import SwiftUI
import Combine

public class GetUserPresenter<Request, Response, Interactor: UseCase>: ObservableObject
where Interactor.Request == Request, Interactor.Response == Response {
  private var cancellables: Set<AnyCancellable> = []
  private var publisher: AnyCancellable?
  private var _useCase: Interactor
  
  @Published public var users: Response?
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false
  
  public init(useCase: Interactor) {
    _useCase = useCase
    
    getUserInfo()
  }
  
  public func getUserInfo() {
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
      }, receiveValue: { user in
        self.users = user
      }).store(in: &cancellables)
  }
  
}
