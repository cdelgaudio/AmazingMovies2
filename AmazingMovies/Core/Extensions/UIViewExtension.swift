//
//  UIViewExtension.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 19/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

extension UIView {
  
  // MARK: Constraint
  
  enum ViewEdge: Equatable {
    case top(margin: CGFloat = 0)
    case bottom(margin: CGFloat = 0)
    case left(margin: CGFloat = 0)
    case right(margin: CGFloat = 0)
  }
  
  func autoPinToSuperview(margin: CGFloat = 0, safe: Bool = false) {
    autoPinToSuperview(
      edges: [
        .top(margin: margin),
        .bottom(margin: margin),
        .left(margin: margin),
        .right(margin: margin)
      ],
      safe: safe
    )
  }
  
  func autoPinToSuperview(edges: [ViewEdge], safe: Bool = false) {
    guard let superview = superview else {
      print("Superview not found")
      return
    }
    translatesAutoresizingMaskIntoConstraints = false
    var constraints: [NSLayoutConstraint] = []
    for edge in edges {
      switch edge {
      case .top(let margin):
        constraints.append(
          safe
            ? superview.safeAreaLayoutGuide.topAnchor.constraint(
              equalTo: self.topAnchor,
              constant: -margin
              )
            : superview.topAnchor.constraint(
              equalTo: self.topAnchor,
              constant: -margin
          )
        )
      case .bottom(let margin):
        constraints.append(
          safe
            ? superview.safeAreaLayoutGuide.bottomAnchor.constraint(
              equalTo: self.bottomAnchor,
              constant: margin
              )
            : superview.bottomAnchor.constraint(
              equalTo: self.bottomAnchor,
              constant: margin
          )
        )
      case .left(let margin):
        constraints.append(
          safe
            ? superview.safeAreaLayoutGuide.leftAnchor.constraint(
              equalTo: self.leftAnchor,
              constant: -margin
              )
            : superview.leftAnchor.constraint(
              equalTo: self.leftAnchor,
              constant: -margin
          )
        )
      case .right(let margin):
        constraints.append(
          safe
            ? superview.safeAreaLayoutGuide.rightAnchor.constraint(
              equalTo: self.rightAnchor,
              constant: margin
              )
            : superview.rightAnchor.constraint(
              equalTo: self.rightAnchor,
              constant: margin
          )
        )
      }
    }
    
    NSLayoutConstraint.activate(constraints)
    superview.setNeedsLayout()
  }
  
  func autoPinDimensions(_ size: CGSize) {
    autoPinWidth(size.width)
    autoPinHeight(size.height)
  }
  
  func autoPinHeight(_ height: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: height).isActive = true
  }
  
  func autoPinWidth(_ width: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    widthAnchor.constraint(equalToConstant: width).isActive = true
  }
  
  func autoCenterToSuperview() {
    guard let superview = superview else {
      print("Superview not found")
      return
    }
    translatesAutoresizingMaskIntoConstraints = false
    centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
  }
  
  
  // MARK: Spacers
  
  static func verticalSpacer(_ height: CGFloat) -> UIView {
    let spacer = UIView()
    spacer.autoPinHeight(height)
    return spacer
  }
  
  static func horizontalSpacer(_ width: CGFloat) -> UIView {
    let spacer = UIView()
    spacer.autoPinWidth(width)
    return spacer
  }
  
  static func flexibleSpacer() -> UIView {
    return UIView()
  }
}
