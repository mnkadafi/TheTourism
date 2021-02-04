//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 29/12/20.
//

import Foundation
import Combine

public struct Interactor<Request, Response, R: Repository>: UseCase
where R.Request == Request, R.Response == Response {
  
  private let _repository: R
  
  public init(repository: R) {
    _repository = repository
  }
  
  public func execute(request: Request?) -> AnyPublisher<Response, Error> {
    _repository.execute(request: request)
  }
  
  public func execute_two(request: Request?, useInfo: Int?) -> AnyPublisher<Bool, Error> {
    _repository.execute_two(request: request, useInfo: useInfo)
  }
}
