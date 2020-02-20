//
//  MovieListCoordinator.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 19/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

final class MovieListRouter: Coordinator {
  
  var child: Coordinator? {
    didSet {
      child?.start()
    }
  }
  
  private let navigation: UINavigationController
    
  init(navigation: UINavigationController) {
    self.navigation = navigation
  }
  
  func start() {
    let viewModel = MovieListViewModel(
      router: self,
      network: NetworkManager(),
      store: StoreManger()
    )
    let controller = MovieListViewController(viewModel: viewModel)
    navigation.pushViewController(controller, animated: true)
  }
}

extension MovieListRouter: MovieListRouting {
  
  func routeToMovieDetails(movie: Movie) {
    child = MovieDetailsRouter(navigation: navigation, movie: movie)
  }
}
