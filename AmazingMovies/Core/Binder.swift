//
//  Bindable.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 19/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

class AbstractBinder<Observed>: Bindable {
  typealias T = Observed
  
  fileprivate var _value: Observed {
    didSet { listeners.array.forEach { $0.fire(_value) } }
  }
  
  private var listeners = SafeArray(array: [Listener<Observed>]())
  
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
    
    listeners.array.append(listener)
    
    if fire {
      callback(_value)
    }
    
    return listener
  }
  
  private func dispose(_ identifier: UUID) {
    listeners.array = listeners.array.filter { $0.identifier != identifier }
  }
}

class Binder<Observed>: AbstractBinder<Observed>, StaticProperty {
  var value: Observed { _value }
}

final class MutableBinder<Observed>: Binder<Observed>, DynamicProperty {
  func modify(_ newValue: Observed) {
    _value = newValue
  }
}

protocol StaticProperty: Bindable {
  var value: T { get }
  
}

protocol DynamicProperty: StaticProperty {  
  func modify(_ value: T)
}

protocol Bindable: AnyObject {
  associatedtype T
  
  func bind(
    fire: Bool,
    on queue: DispatchQueue?,
    observer: @escaping (T) -> Void
  ) -> Disposable
}

extension Bindable {
  func bind(
    fire: Bool = false,
    on queue: DispatchQueue? = nil,
    observer: @escaping (T) -> Void
  ) -> Disposable {
    bind(fire: fire, on: queue, observer: observer)
  }
}
