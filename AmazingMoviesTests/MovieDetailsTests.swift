//
//  MovieDetailsTests.swift
//  AmazingMoviesTests
//
//  Created by Carmine Del Gaudio on 20/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import XCTest
@testable import AmazingMovies

class MovieDetailsTests: XCTestCase {
  
  let movie = Movie(popularity: nil, voteCount: nil, video: nil, posterPath: "", id: 1, adult: nil, backdropPath: nil, originalLanguage: nil, originalTitle: nil, title: nil, voteAverage: nil, overview: nil, releaseDate: nil)
  
  func testTitle() {
    let viewModel = MovieDetailsViewModel(movie: movie)
    
    XCTAssert(viewModel.title == "Movie")
  }
  
  func testRows() {
    let viewModel = MovieDetailsViewModel(movie: movie)
    
    XCTAssert(!viewModel.rows.isEmpty)
  }
  
}
