//
//  MovieItemTests.swift
//  AmazingMoviesTests
//
//  Created by Carmine Del Gaudio on 20/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import XCTest
@testable import AmazingMovies

class MovieItemTests: XCTestCase {
  
  let movie = Movie(popularity: nil, voteCount: nil, video: nil, posterPath: "", id: 1, adult: nil, backdropPath: nil, originalLanguage: nil, originalTitle: nil, title: nil, voteAverage: nil, overview: nil, releaseDate: nil)
  
  let image: UIImage? = {
    let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(UIColor.white.cgColor)
    context?.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }()
  
  func testFailure() {
    let viewModel = MovieItemViewModel(
      movie: movie,
      network: NetworkMock(type: .failure)
    )
    viewModel.start()
    
    switch viewModel.state.value {
    case .failed:
      XCTAssert(true)
    default:
      XCTAssert(false)
    }
  }
  
  func testLoading() {
    let viewModel = MovieItemViewModel(
      movie: movie,
      network: NetworkMock(type: .loading)
    )
    viewModel.start()
    
    switch viewModel.state.value {
    case .loading:
      XCTAssert(true)
    default:
      XCTAssert(false)
    }
  }
  
  func testSuccess() {
    let viewModel = MovieItemViewModel(
      movie: movie,
      network: NetworkMock(type: .success(movies: nil, image: image?.pngData()))
    )
    viewModel.start()
    
    switch viewModel.state.value {
    case .completed:
      XCTAssert(true)
    default:
      XCTAssert(false)
    }
  }
  
  func testTitle() {
    let viewModel = MovieItemViewModel(
      movie: movie,
      network: NetworkMock(type: .success(movies: nil, image: nil))
    )
    viewModel.start()
    
    XCTAssert(viewModel.title == "---")
  }
  
}
