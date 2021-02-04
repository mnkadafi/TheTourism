//
//  APICall.swift
//  TheTourism
//
//  Created by Mochamad Nurkhayal Kadafi on 10/12/20.
//

import Foundation

struct API {
  
  static let baseURL = "https://tourism-api.dicoding.dev/"
  
}

protocol Endpoint {
  
  var url: String { get }
  
}

enum Endpoints {
  
  enum Gets: Endpoint {
    case list
    
    public var url: String {
      switch self {
      case .list:
        return "\(API.baseURL)list"
      }
    }
  }
  
}
