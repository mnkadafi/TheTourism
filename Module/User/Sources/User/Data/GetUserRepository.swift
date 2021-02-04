//
//  File.swift
//  
//
//  Created by Mochamad Nurkhayal Kadafi on 25/01/21.
//

import Core
import Combine

public struct GetUserRepository<
  PUserLocaleDataSource: UserLocaleDataSource,
  Transformer: Mapper>: Repository
where
  PUserLocaleDataSource.Response == UserModuleEntity,
  Transformer.Response == Any,
  Transformer.Entity == UserModuleEntity,
  Transformer.Domain == UserDomainModel {
  
  public typealias Request = Any
  public typealias Response = UserDomainModel
  
  private let _localeDataSource: PUserLocaleDataSource
  private let _mapper: Transformer
  
  public init(
    localeDataSource: PUserLocaleDataSource,
    mapper: Transformer) {
    _localeDataSource = localeDataSource
    _mapper = mapper
  }
  
  public func execute(request: Any?) -> AnyPublisher<UserDomainModel, Error> {
    return _localeDataSource.getUser(request: nil)
      .map { _mapper.transformEntityToDomain(entity: $0) }
      .eraseToAnyPublisher()
  }
  
  public func execute_two(request: Any?, useInfo: Int?) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
}
