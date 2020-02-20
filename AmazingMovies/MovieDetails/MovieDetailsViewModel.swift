//
//  MovieDetailsViewModel.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 20/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

final class MovieDetailsViewModel {
  
  struct Row {
    var key: String
    var value: String?
  }
  
  // MARK: Properties

  let rows: [Row]

  var title: String { movie.title ?? "Movie" }
  
  private let movie: Movie
  
  // MARK: Init

  init(movie: Movie) {
    self.movie = movie
    rows = [
      .init(key: "Score", value: "\(movie.voteAverage?.rounded() ?? 0)"),
      .init(key: "Language", value: movie.originalLanguage),
      .init(key: "Release Date", value: movie.releaseDate),
      .init(key: "Description", value: movie.overview)
    ]
  }
}
