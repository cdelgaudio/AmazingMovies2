//
//  Coordinator.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 19/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
  var parent: Router? { get set }
  var child: Router? { get set }
  func start()
}

class Router: NSObject, Coordinator {
  
  weak var parent: Router?
  
  var child: Router? {
    didSet {
      
      child?.parent = self
      child?.start()
    }
  }
  
  func start() {
    fatalError("overrideThis")
  }
}

extension Router: UINavigationControllerDelegate {
  func navigationController(
    _ navigationController: UINavigationController,
    didShow viewController: UIViewController,
    animated: Bool
  ) {
    guard
      let fromViewController = navigationController
        .transitionCoordinator?
        .viewController(forKey: .from),
      !navigationController.viewControllers.contains(fromViewController)
      else { return }
    parent?.child = nil
  }
}
