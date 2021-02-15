//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 12/02/21.
//

import Core
import Combine
import Alamofire
import Foundation

public struct GetDetailDestinationRemoteDataSource: DataSource {
  
  public typealias Request = String
  public typealias Response = DestinationResponse
  private let _endpoint: String
  
  public init(endpoint: String) {
    _endpoint = endpoint
  }
  
  public func execute(request: String?) -> AnyPublisher<DestinationResponse, Error> {
    return Future<DestinationResponse, Error> { completion in
      if let url = URL(string: _endpoint) {
        AF.request(url)
          .validate()
          .responseDecodable(of: DestinationsResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value.places[0]))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
  
}
