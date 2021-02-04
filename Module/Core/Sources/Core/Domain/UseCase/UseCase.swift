//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 29/12/20.
//

import Combine

public protocol UseCase {
  associatedtype Request
  associatedtype Response
  
  func execute(request: Request?) -> AnyPublisher<Response, Error>
  func execute_two(request: Request?, useInfo: Int?) -> AnyPublisher<Bool, Error>
}
