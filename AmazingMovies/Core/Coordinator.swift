//
//  Coordinator.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 19/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

// for demo purpose I'm not going to handle the back
protocol Coordinator: AnyObject {
  var child: Coordinator? { get set }
  func start()
}
