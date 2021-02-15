//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 29/12/20.
//

import Combine

public protocol LocaleDataSource {
  associatedtype Request
  associatedtype Response
  
  func list(request: Request?) -> AnyPublisher<[Response], Error>
  func add(entities: [Response]) -> AnyPublisher<Bool, Error>
  func get(request: String) -> AnyPublisher<Response, Error>
  func update(id: String?, entity: Response) -> AnyPublisher<Bool, Error>
  func search(title: String) -> AnyPublisher<[Response], Error>
}
