//
//  HomeViewController.swift
//  EcommerceApp
//
//  Created by Beyza Nur Tekerek on 23.05.2025.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController {
    
    private let viewModel = HomeViewModel()
    private var products: [Product] = []
    private var filteredProducts: [Product] = []
    private var collectionView: CollectionView<Product, ProductCollectionViewCell>?
    var errorView: ErrorView = ErrorView()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search..."
        searchBar.searchBarStyle = .minimal
        searchBar.layer.cornerRadius = 4
        searchBar.layer.masksToBounds = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let filterLabel: UILabel = {
        let label = UILabel()
        label.text = "Filters:"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Filter", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var filterStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [filterLabel, filterButton])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        applyConstraints()
        bind()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(searchBar)
        view.addSubview(filterStackView)
        view.addSubview(errorView)
        
        errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true

        
        collectionView = CollectionView<Product, ProductCollectionViewCell>(
            cellClass: ProductCollectionViewCell.self,
            itemSize: CGSize(width: (view.frame.width - 48) / 2, height: 300),
            configureCell: { cell, product in
                cell.configure(with: product)
            }
        )
        
        if let collectionView = collectionView {
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(collectionView)
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: filterStackView.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
    
    private func applyConstraints() {
        let searchBarConstraints = [
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let filterStackViewConstraints = [
            filterStackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            filterStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            filterStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            filterStackView.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let allConstraints = [
            searchBarConstraints,
            filterStackViewConstraints
        ].flatMap { $0 }
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
}

private extension HomeViewController {
    func bind() {
        bindProducts()
    }
    
    func bindProducts() {
        viewModel.filteredProducts
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] products in
                guard let self else { return }
                if let products = products {
                    collectionView?.isHidden = false
                    errorView.isHidden = true
                    collectionView?.updateItems(products)
                } else {
                    collectionView?.isHidden = false
                    errorView.isHidden = false
                }
            })
            .disposed(by: disposeBag)
        bindLoadingStatus(to: viewModel.loadingStatus)
    }
}

// extension product delegate eklenecek
// search bar delegate eklenecek
//
