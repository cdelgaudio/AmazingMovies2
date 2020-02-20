//
//  MovieDetailsViewController.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 20/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

// Sorry for the design of this screen but I'm out of time

final class MovieDetailsViewController: UIViewController {
  
  // MARK: Properties
  
  private let viewModel: MovieDetailsViewModel
  
  // MARK: Init
  
  init(viewModel: MovieDetailsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    makeView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: View
  
  private func makeView() {
    view.backgroundColor = .white
    title = viewModel.title
    makeMainStack()
  }
  
  private func makeMainStack() {
    let stack = UIStackView(arrangedSubviews:
      viewModel.rows
        .filter { $0.value != nil }
        .map { makeSectionStack(title: $0.key, description: $0.value!)}
    )
    stack.addArrangedSubview(.flexibleSpacer())
    stack.axis = .vertical
    stack.spacing = 30
    view.addSubview(stack)
    stack.autoPinToSuperview(edges: [
      .top(margin: 20),
      .bottom(),
      .left(margin: 30),
      .right(margin: 30)
    ], safe: true)
  }
  
  private func makeSectionStack(
    title: String,
    description: String
  ) -> UIStackView {
    let stack = UIStackView(arrangedSubviews: [
      makeTitleLabel(text: title),
      makeDescriptionLabel(text: description)
    ])
    stack.spacing = 10
    stack.axis = .vertical
    return stack
  }
  
  private func makeTitleLabel(text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    label.font = label.font.withSize(20)
    label.textColor = .black
    return label
  }
  
  private func makeDescriptionLabel(text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    label.font = label.font.withSize(15)
    label.textColor = .darkGray
    label.numberOfLines = 0
    return label
  }
}
