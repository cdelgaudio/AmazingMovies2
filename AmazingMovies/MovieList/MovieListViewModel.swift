//
//  MovieListViewModel.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 19/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

protocol MovieListRouting: AnyObject {
  func routeToMovieDetails(movie: Movie)
}

final class MovieListViewModel {
  
  enum State {
    case loading, failed, compelted
  }
  
  // MARK: Properties
  
  var state: Binder<State> { _state }
  
  private (set) var movieList: [MovieItemViewModel] = []
  
  private let _state: MutableBinder<State>
  
  private let network: Networking
  
  private unowned let router: MovieListRouting
  
  init(router: MovieListRouting, network: Networking) {
    self.router = router
    self.network = network
    _state = MutableBinder(.failed)
  }
  
  // MARK: Methods
  
  func start() {
    guard case .failed = _state.value else { return }
    callGetMovies(page: 1)
  }
  
  func movieSelected(index: Int) {
    router.routeToMovieDetails(movie: movieList[index].movie)
  }
  
  // MARK: Network

  private func callGetMovies(page: Int) {
    _state.value = .loading
    network.getMovies(page: page) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let response):
        self.movieList = response.results
          .map { MovieItemViewModel(movie: $0, network: self.network) }
        self._state.value = .compelted
      case .failure:
        self._state.value = .failed
      }
    }
  }
}
