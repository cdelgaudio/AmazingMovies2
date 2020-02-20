//
//  NetworkMock.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 20/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

final class NetworkMock: Networking {
  
  enum MockType {
    case success(movie: MoviesResponse? = nil, image: Data? = nil)
    case failure
    case loading
  }
  
  private let type: MockType
  
  init(type: MockType) {
    self.type = type
  }
  
  func getMovies(
    page: Int,
    completion: @escaping (NetworkResult<MoviesResponse>) -> Void
  ) {
    switch type {
    case .success(let response, _):
      guard let response = response else { return }
      completion(.success(response))
    case .failure:
      completion(.failure(.network(description: "Test error")))
    case .loading:
      break
    }
  }
  
  func downloadImage(
    path: String,
    completion: @escaping (NetworkResult<Data>) -> Void
  ) {
    switch type {
    case .success(_, let response):
      guard let reposnse = response else { return }
      completion(.success(reposnse))
    case .failure:
      completion(.failure(.network(description: "Test error")))
    case .loading:
      break
    }
  }
  
  
}
