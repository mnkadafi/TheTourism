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
  
  func getListDestination(request: Request?) -> AnyPublisher<[Response], Error>
  func addListDestination(entities: [Response]) -> AnyPublisher<Bool, Error>
  func getDetailDestination(request: Int?) -> AnyPublisher<Response, Error>
  func getFavoriteList(request: Request?) -> AnyPublisher<[Response], Error>
  func isFavoriteDestination(entity: Response) -> AnyPublisher<Bool, Error>
  func addToFavoriteDestination(entity: Response) -> AnyPublisher<Bool, Error>
  func removeFavoriteDestination(entity: Response) -> AnyPublisher<Bool, Error>
  func searchFavoriteByTitle(title: String) -> AnyPublisher<[Response], Error>
}
