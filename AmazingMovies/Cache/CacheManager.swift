//
//  CacheManager.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 25/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

protocol Caching: AnyObject {
  func getImage(for path: String?) -> UIImage?
  func setImage(image: UIImage, path: String?)
}

final class CacheManager: Caching {
  
  private let cache = NSCache<AnyObject, UIImage>()
  
  func getImage(for path: String?) -> UIImage? {
    cache.object(forKey: path as AnyObject)
  }
  
  func setImage(image: UIImage, path: String?) {
    cache.setObject(image, forKey: path as AnyObject)
  }
  
}
