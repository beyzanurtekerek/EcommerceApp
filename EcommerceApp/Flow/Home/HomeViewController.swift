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
        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(searchBar)
        view.addSubview(filterStackView)
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
