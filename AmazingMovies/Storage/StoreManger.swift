//
//  StoreManger.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 20/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

// Create a CoreData layer require too much time

protocol Storing: AnyObject {
  var movies: [Movie] { get set }
}

final class StoreManger: Storing {
  
  var movies: [Movie] = [] {
    didSet {
      try? PropertyListEncoder()
        .encode(movies)
        .write(to: url, options: .noFileProtection)
    }
  }
  
  private let url: URL
  
  init() {
    url = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)
      .first!
      .appendingPathComponent("Movies")
      .appendingPathExtension("plist")
    
    let decoder = PropertyListDecoder()
    
    guard
      let data = try? Data(contentsOf: url),
      let list = try? decoder.decode([Movie].self,from: data)
      else {
        return
    }
    movies = list
  }
}


