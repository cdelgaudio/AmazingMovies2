//
//  NetworkManager.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 19/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

typealias NetworkResult<D: Decodable> = Result<D, NetworkError>

enum NetworkError: Error {
  case parsing(description: String)
  case network(description: String)
  case request
}

protocol Networking {
  
  func getMovies(
    page: Int,
    completion: @escaping (NetworkResult<MoviesResponse>) -> Void
  )
  
  func downloadImage(
    path: String,
    completion: @escaping (NetworkResult<Data>) -> Void
  )
}

// To respect the deadline I handled just the Get requests
final class NetworkManager {
  
  let session = URLSession.shared
  
  @discardableResult
  private func get<D: Decodable>(
    url: URL?,
    completion: @escaping (NetworkResult<D>) -> Void
  ) -> URLSessionDataTask? {
    guard let url = url else {
      completion(.failure(.request))
      return nil
    }
    
    let task = session.codableTask(with: url, completionHandler: completion)
    task.resume()
    return task
  }
  
  @discardableResult
  private func download(
    url: URL?,
    completion: @escaping (NetworkResult<Data>) -> Void
  ) -> URLSessionDownloadTask? {
    guard let url = url else {
      completion(.failure(.request))
      return nil
    }
    
    let task = session.downloadTask(with: url, completionHandler: completion)
    task.resume()
    return task
  }
}

// MARK: Networking

extension NetworkManager: Networking {
  func downloadImage(
    path: String,
    completion: @escaping (NetworkResult<Data>) -> Void
  ) {
    download(url: NetworkRequest.image(path: path).url, completion: completion)
  }
  
  func getMovies(
    page: Int,
    completion: @escaping (NetworkResult<MoviesResponse>) -> Void
  ) {
    get(url: NetworkRequest.movies(page: page).url, completion: completion)
  }
  
}

// MARK: URLSession

private extension URLSession {
  func codableTask<D: Decodable>(
    with url: URL,
    completionHandler: @escaping (NetworkResult<D>) -> Void
  ) -> URLSessionDataTask {
    self.dataTask(with: url) { data, response, error in
      guard let data = data else {
        let errorDescription = error?.localizedDescription ?? "No Data"
        completionHandler(.failure(.network(description: errorDescription)))
        return
      }
      do {
        completionHandler(.success(try JSONDecoder().decode(D.self, from: data)))
      } catch {
        let error = NetworkError.parsing(description: error.localizedDescription)
        completionHandler(.failure(error))
      }
    }
  }
  
  func downloadTask(
    with url: URL,
    completionHandler: @escaping (NetworkResult<Data>) -> Void
  ) -> URLSessionDownloadTask {
    self.downloadTask(with: url) { path, response, error in
      guard let path = path else {
        let errorDescription = error?.localizedDescription ?? "No Path"
        completionHandler(.failure(.network(description: errorDescription)))
        return
      }
      do {
        completionHandler(.success(try Data(contentsOf: path)))
      } catch {
        let error = NetworkError.parsing(description: error.localizedDescription)
        completionHandler(.failure(error))
      }
    }
  }
}
