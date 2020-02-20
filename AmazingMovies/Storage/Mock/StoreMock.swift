//
//  StoreMock.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 20/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

final class StoreMock: Storing {
  enum MockType {
    case empty
    case filled(movie: Movie)
  }
  
  var movies: [Movie]
  
  init(type: MockType) {
    switch type {
    case .empty:
      movies = []
    case .filled(let movie):
      movies = [movie]
    }
  }
}
