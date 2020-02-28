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
  
  private var disposeBag: [Disposable] = []

  // MARK: Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    makeView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    disposeBag.forEach { $0.dispose($0.identifier) }
  }
    
  func configure(viewModel: MovieItemViewModel) {
    self.viewModel = viewModel
    makeBindings()
    titleLabel.text = viewModel.title
    viewModel.start()
  }
  
  // MARK: Bindings
  
  private func makeBindings() {
    guard let viewModel = viewModel else { return }
    let disposable = viewModel.state.bind(fire: true, on: .main) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .failed:
        // TODO: Asset missing image
        self.imageView.backgroundColor = .red
        self.imageView.image = nil
      case .loading:
        // TODO: ActivityIndicator
        self.imageView.backgroundColor = .lightGray
        self.imageView.image = nil
      case .completed:
        self.imageView.backgroundColor = .clear
        self.imageView.image = viewModel.image
      }
    }
    disposeBag.append(disposable)
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
