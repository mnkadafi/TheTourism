//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 25/01/21.
//

import Combine

public protocol UserLocaleDataSource {
  associatedtype Request
  associatedtype Response
  
  func getUser(request: Request?) -> AnyPublisher<Response, Error>
  func addUser(entities: Response) -> AnyPublisher<Bool, Error>
}
