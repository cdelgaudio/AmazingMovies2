//
//  AmazingMoviesTests.swift
//  AmazingMoviesTests
//
//  Created by Carmine Del Gaudio on 19/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import XCTest
@testable import AmazingMovies

class MovieListTests: XCTestCase {
  
  let response = MoviesResponse(
    page: 1,
    totalResults: 1,
    totalPages: 1,
    results: [Movie(popularity: nil, voteCount: nil, video: nil, posterPath: "", id: 1, adult: nil, backdropPath: nil, originalLanguage: nil, originalTitle: nil, title: nil, voteAverage: nil, overview: nil, releaseDate: nil)])
  
  func testFailure() {
    let coordinator = MovieListRouter(navigation: UINavigationController())
    let viewModel = MovieListViewModel(
      router: coordinator,
      network: NetworkMock(type: .failure),
      store: StoreMock(type: .empty)
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
    let coordinator = MovieListRouter(navigation: UINavigationController())
    let viewModel = MovieListViewModel(
      router: coordinator,
      network: NetworkMock(type: .loading),
      store: StoreMock(type: .empty)
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
    let coordinator = MovieListRouter(navigation: UINavigationController())
    let viewModel = MovieListViewModel(
      router: coordinator,
      network: NetworkMock(type: .success(movies: response, image: nil)),
      store: StoreMock(type: .empty)
    )
    viewModel.start()
    
    switch viewModel.state.value {
    case .completed:
      XCTAssert(!viewModel.movieList.isEmpty)
    default:
      XCTAssert(false)
    }
  }
  
  func testReadStored() {
    let coordinator = MovieListRouter(navigation: UINavigationController())
    let viewModel = MovieListViewModel(
      router: coordinator,
      network: NetworkMock(type: .failure),
      store: StoreMock(type: .filled(movie: response.results[0]))
    )
    viewModel.start()
    
    switch viewModel.state.value {
    case .completed:
      XCTAssert(!viewModel.movieList.isEmpty)
    default:
      XCTAssert(false)
    }
  }
  
  func testRouting() {
    let coordinator = MovieListRouter(navigation: UINavigationController())
    let viewModel = MovieListViewModel(
      router: coordinator,
      network: NetworkMock(type: .success(movies: response, image: nil)),
      store: StoreMock(type: .empty)
    )
    viewModel.start()
    XCTAssert(coordinator.child == nil)
    viewModel.movieSelected(index: 0)
    XCTAssert(coordinator.child != nil)
  }
  
}
