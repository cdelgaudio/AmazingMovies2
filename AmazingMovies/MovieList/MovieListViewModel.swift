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
    case loading, failed, completed
  }
  
  // MARK: Properties
  
  var state: Binder<State> { _state }
  
  private (set) var movieList: [MovieItemViewModel] = []
  
  private let _state: MutableBinder<State>
  
  private let network: Networking
  
  private let store: Storing
  
  private let cache: Caching

  private unowned let router: MovieListRouting
  
  // MARK: Init

  init(components: MovieListComponents) {
    router = components.router
    network = components.network
    store = components.store
    cache = components.cache
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
    _state.modify(.loading)
    network.getMovies(page: page) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let response):
        self.store.movies = response.results
        self.movieList = response.results
          .map {
            MovieItemViewModel(
              movie: $0,
              network: self.network,
              cache: self.cache
            )
        }
        self._state.modify(.completed)
      case .failure:
        self.getStored()
      }
    }
  }
  
  private func getStored() {
    guard !store.movies.isEmpty else {
      _state.modify(.failed)
      return
    }
    movieList = store.movies
      .map { MovieItemViewModel(movie: $0, network: network, cache: cache) }
    _state.modify(.completed)
  }
}
