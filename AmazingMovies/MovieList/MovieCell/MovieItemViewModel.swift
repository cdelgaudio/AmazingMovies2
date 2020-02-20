//
//  MovieItemViewModel.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 19/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

final class MovieItemViewModel {
  
  enum State {
    case failed, loading, completed(image: UIImage)
  }
  
  // MARK: Properties

  var title: String { movie.title ?? "---" }
  
  var state: Binder<State> { _state }
  
  private let _state: MutableBinder<State>
  
  private let network: Networking
  
  let movie: Movie
  
  // MARK: Init

  init(movie: Movie, network: Networking) {
    self.movie = movie
    self.network = network
    _state = MutableBinder(.failed)
  }
  
  // MARK: Methods
  
  func start() {
    guard case .failed = _state.value else { return }
    callDownloadImage()
  }
  
  // MARK: Network

  func callDownloadImage() {
    guard let path = movie.posterPath else { return }
    _state.value = .loading
    network.downloadImage(path: path) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let data):
        guard let image = UIImage(data: data) else { return }
        self._state.value = .completed(image: image)
      case .failure:
        self._state.value = .failed
      }
    }
  }
  
}
