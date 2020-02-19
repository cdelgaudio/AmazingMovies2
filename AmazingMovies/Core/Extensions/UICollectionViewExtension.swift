//
//  UICollectionViewExtension.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 19/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

extension UICollectionView {
  func register<Cell: UICollectionViewCell>(_: Cell.Type) {
      register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
  }
  
  func dequeue<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
    dequeueReusableCell(
      withReuseIdentifier: Cell.identifier,
      for: indexPath
    ) as! Cell
  }
}
