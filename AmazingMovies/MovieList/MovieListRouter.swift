//
//  MovieListCoordinator.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 19/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

final class MovieListRouter: Coordinator {
  
  private let navigation: UINavigationController
  
  init(navigation: UINavigationController) {
    self.navigation = navigation
  }
  
  func start() {
    let viewModel = MovieListViewModel(router: self, network: NetworkManager())
    let controller = MovieListViewController(viewModel: viewModel)
    navigation.pushViewController(controller, animated: true)
  }
}

extension MovieListRouter: MovieListRouting {
  
}
