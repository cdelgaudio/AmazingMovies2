//
//  MovieDetailsRouter.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 20/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

final class MovieDetailsRouter: Router {
  
  private let navigation: UINavigationController
    
  private let movie: Movie
  
  init(navigation: UINavigationController, movie: Movie) {
    self.navigation = navigation
    self.movie = movie
  }
  
  override func start() {
    // I prefer not inject the router in the ViewModel if it is not required
    navigation.delegate = self
    let viewModel = MovieDetailsViewModel(movie: movie)
    let controller = MovieDetailsViewController(viewModel: viewModel)
    navigation.pushViewController(controller, animated: true)
  }
}
