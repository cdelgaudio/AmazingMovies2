//
//  MoviesResponse.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 19/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

struct MoviesResponse: Codable {
  
  let page: Int
  let totalResults: Int
  let totalPages: Int
  let results: [Movie]
  
  enum CodingKeys: String, CodingKey {
    case page
    case totalResults = "total_results"
    case totalPages = "total_pages"
    case results
  }
}

