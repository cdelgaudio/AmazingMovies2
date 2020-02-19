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
  
  var title: String { movie.title ?? "---" }
  
  private let network: Networking
  
  private let movie: Movie
  
  init(movie: Movie, network: Networking) {
    self.movie = movie
    self.network = network
  }
  
  func start() {
  }
  
}
