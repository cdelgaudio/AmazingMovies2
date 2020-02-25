//
//  SafeArray.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 24/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

final class SafeArray<T> {
  private let queue = DispatchQueue(
  label: "SafeArray",
  qos: .userInteractive,
  attributes: .concurrent
  )
  
  var array: [T] {
    get {
      queue.sync {
        return _array
      }
    }
    set {
      queue.async { [weak self] in
        self?._array = newValue
      }
    }
  }
  
  private var _array: [T]
  
  init(array: [T]) {
    self._array = array
  }
  
  
  
}
