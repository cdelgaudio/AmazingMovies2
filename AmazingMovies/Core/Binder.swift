//
//  Bindable.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 19/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

// not thread safe but for a demo test probably I worked too much on it
class Binder<Observed> {
    
  var value: Observed { _value }

  fileprivate var _value: Observed {
    didSet { listeners.forEach { $0.fire(_value) } }
  }
  
  private var listeners: [Listener<Observed>] = []
  
  init(_ value: Observed) {
    self._value = value
  }
  
  func bind(
    fire: Bool = false,
    on queue: DispatchQueue? = nil,
    observer: @escaping (Observed) -> Void
  ) -> Disposable {
    let callback: (Observed) -> Void
    if let queue = queue {
      callback = { value in
        queue.async {
          observer(value)
        }
      }
    } else {
      callback = observer
    }
    
    let listener = Listener(fire: callback) { [weak self] in
      self?.dispose($0)
    }
    
    listeners.append(listener)
    
    if fire {
      callback(_value)
    }
    
    return listener
  }
  
  private func dispose(_ identifier: UUID) {
    listeners.removeAll { $0.identifier == identifier }
  }
}

final class MutableBinder<Observed>: Binder<Observed> {
  
  override var value: Observed {
    get { _value }
    set { _value = newValue }
  }
}

