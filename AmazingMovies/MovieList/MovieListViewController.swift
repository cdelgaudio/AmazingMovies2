//
//  ViewController.swift
//  AmazingMovies
//
//  Created by Carmine Del Gaudio on 19/02/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

final class MovieListViewController: UIViewController {
  
  private enum Constants {
    static let spacing: CGFloat = 5
  }
  // MARK: Properties
  
  private let viewModel: MovieListViewModel
  
  private var disposeBag: [Disposable] = []
  
  private let collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumLineSpacing = Constants.spacing
    flowLayout.minimumInteritemSpacing = Constants.spacing
    flowLayout.scrollDirection = .vertical
    return .init(frame: .zero, collectionViewLayout: flowLayout)
  }()
  
  // MARK: Init

  init(viewModel: MovieListViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    makeView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    makeBindings()
    viewModel.start()
  }
  
  // MARK: Bindings
  
  private func makeBindings() {
    disposeBag.append(
      viewModel.state.bind(on: .main) { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .loading:
          // TODO: ActivityIndicator
          self.collectionView.isHidden = true
        case .failed:
          self.collectionView.isHidden = true
          let alert = UIAlertController(
            title: "Error!",
            message: "Connection Error",
            preferredStyle: .alert
          )
          self.present(alert, animated: true)
        case .compelted:
          self.collectionView.isHidden = false
          self.collectionView.reloadData()
        }
      }
    )
  }
  
  // MARK: View

  private func makeView() {
    title = "Top Movies"
    view.backgroundColor = .white
    makeCollectionView()
  }
  
  private func makeCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(MovieItemViewCell.self)
    collectionView.backgroundColor = .clear
    view.addSubview(collectionView)
    collectionView.autoPinToSuperview()
  }
  
}

// MARK: UITableViewDataSource

extension MovieListViewController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    viewModel.movieList.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell: MovieItemViewCell = collectionView.dequeue(for: indexPath)
    cell.configure(viewModel: viewModel.movieList[indexPath.row])
    return cell
  }
}

// MARK: UITableViewDelegate

extension MovieListViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    viewModel.movieSelected(index: indexPath.row)
  }
}

// MARK: UICollectionViewDelegateFlowLayout

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let width = (collectionView.bounds.width - Constants.spacing) / 2
    return CGSize(width: width, height: width * 1.5)
  }
}

