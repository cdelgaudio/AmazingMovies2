//
//  Bindable.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 19/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

class Binder<Observed> {
  
  typealias Listener = (Observed) -> Void
  
  var value: Observed { _value }

  fileprivate var _value: Observed {
    didSet { listener?(_value) }
  }
  
  private var listener: Listener?
  
  init(_ value: Observed) {
    self._value = value
  }
  
  func bind(
    fire: Bool = false,
    on queue: DispatchQueue? = nil,
    listener: @escaping Listener
  ) {
    if let queue = queue {
      self.listener = { value in
        queue.async {
          listener(value)
        }
      }
    } else {
      self.listener = listener
    }
    
    if fire {
      self.listener?(_value)
    }
  }
}

final class MutableBinder<Observed>: Binder<Observed> {
  
  override var value: Observed {
    get { _value }
    set { _value = newValue }
  }
}
