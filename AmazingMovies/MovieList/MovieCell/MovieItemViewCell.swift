//
//  UICollectionViewCell.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 19/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

final class MovieItemViewCell: UICollectionViewCell {
  
  // MARK: Properties

  private let titleLabel = UILabel()
  
  private let imageView = UIImageView()
  
  private var viewModel: MovieItemViewModel?

  override init(frame: CGRect) {
    super.init(frame: frame)
    makeView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
  func configure(viewModel: MovieItemViewModel) {
    self.viewModel = viewModel
    titleLabel.text = viewModel.title
  }
  
  // MARK: View

  private func makeView() {
    makeImageView()
    makeTitleLabel()
  }
  
  private func makeImageView() {
    imageView.backgroundColor = .lightGray
    imageView.contentMode = .scaleAspectFit
    contentView.addSubview(imageView)
    imageView.autoPinToSuperview()
  }
  
  private func makeTitleLabel() {
    titleLabel.textColor = .white
    titleLabel.backgroundColor = .darkGray
    titleLabel.numberOfLines = 5
    titleLabel.textAlignment = .center
    contentView.addSubview(titleLabel)
    titleLabel.autoPinToSuperview(edges: [.bottom(), .left(), .right()])
  }
  
}
