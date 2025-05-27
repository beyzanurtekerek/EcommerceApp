//
//  ProductCollectionViewCell.swift
//  EcommerceApp
//
//  Created by Beyza Nur Tekerek on 25.05.2025.
//

import UIKit
import Kingfisher

protocol ProductCollectionViewCellDelegate: AnyObject {
    func didTapFavoriteButton(in cell: ProductCollectionViewCell)
    func didTapAddToCartButton(in cell: ProductCollectionViewCell)
}

class ProductCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    weak var delegate: ProductCollectionViewCellDelegate?
    private var isFavorite: Bool = false
    
    // MARK: - UI Components
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemOrange.withAlphaComponent(0.9)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let imageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        applyConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.applyShadow()
        contentView.addSubview(stackView)
        
        imageContainerView.addSubview(productImageView)
        imageContainerView.addSubview(favoriteButton)
        
        stackView.addArrangedSubview(imageContainerView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(addToCartButton)
    }
    
    // MARK: - Constraints
    private func applyConstraints() {
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ]
        let productImageViewConstraints = [
            productImageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 160)
        ]
        let favoriteButtonConstraints = [
            favoriteButton.topAnchor.constraint(equalTo: imageContainerView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24)
        ]
        let titleLabelConstraints = [
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 34)
        ]
        let priceLabelConstraints = [
            priceLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        let addToCartButtonConstraints = [
            addToCartButton.heightAnchor.constraint(equalToConstant: 36)
        ]
        
        let allConstraints = [
            stackViewConstraints,
            productImageViewConstraints,
            favoriteButtonConstraints,
            titleLabelConstraints,
            priceLabelConstraints,
            addToCartButtonConstraints
        ].flatMap { $0 }
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    // MARK: - Actions & Actions Setup
    private func setupActions() {
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        addToCartButton.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
    }
    
    @objc private func favoriteButtonTapped() {
        isFavorite.toggle()
        
        let imageName = isFavorite ? "heart.fill" : "heart"
        let tintColor = isFavorite ? UIColor.systemRed : UIColor.systemGray
        
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favoriteButton.tintColor = tintColor
        
        delegate?.didTapFavoriteButton(in: self)
    }
    
    @objc private func addToCartButtonTapped() {
        delegate?.didTapAddToCartButton(in: self)
    }
    
    // MAR: - Configure Cell
    func configure(with product: Product) {
        productImageView.kf.setImage(with: URL(string: product.thumbnail ?? ""), placeholder: UIImage(named: "placeholder"))
        productImageView.contentMode = .scaleAspectFill
        priceLabel.text = "$\(product.price ?? 0)"
        titleLabel.text = product.title
        
        isFavorite = product.isFavorite ?? false
        let imageName = isFavorite ? "heart.fill" : "heart"
        let tintColor = isFavorite ? UIColor.systemRed : UIColor.systemGray
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favoriteButton.tintColor = tintColor
    }
    
}
