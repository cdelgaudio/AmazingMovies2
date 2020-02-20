//
//  Listener.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 20/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

protocol Disposable: AnyObject {
  
  var identifier: UUID { get }
  
  var dispose: (UUID) -> Void { get }
  
}

protocol Observable: AnyObject {
  associatedtype Observed
    
  var fire: (Observed) -> Void { get }
}

final class Listener<Observed>: Observable, Disposable {
  
  let identifier = UUID()
  
  let dispose: (UUID) -> Void
  
  var fire: (Observed) -> Void
  
  init(fire: @escaping (Observed) -> Void, dispose: @escaping (UUID) -> Void) {
    self.dispose = dispose
    self.fire = fire
  }
  
  deinit {
    dispose(identifier)
  }
}




