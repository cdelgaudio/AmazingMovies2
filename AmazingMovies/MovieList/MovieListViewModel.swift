//
//  MovieListViewModel.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 19/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

protocol MovieListRouting: AnyObject {
}

final class MovieListViewModel {
  
  private unowned let router: MovieListRouting
  
  init(router: MovieListRouting) {
    self.router = router
  }
}
