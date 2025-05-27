//
//  HomeViewModel.swift
//  EcommerceApp
//
//  Created by Beyza Nur Tekerek on 25.05.2025.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    private let disposeBag = DisposeBag()
    private let networkManager: NetworkManagerProtocol
    let loadingStatus = BehaviorRelay<LoadingStatus>(value: .initial)
    let products = BehaviorRelay<[Product]?>(value: nil)
    let filteredProducts = BehaviorRelay<[Product]?>(value: nil)
    let filterOption = BehaviorRelay<FilterOption?>(value: nil)
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
        fetchProducts()
    }
    
    func fetchProducts() {
        loadingStatus.accept(.loading)
        networkManager.request(
            path: NetworkPaths.products.rawValue,
            method: .get,
            headers: nil,
            parameters: nil,
            responseType: ProductResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let response):
                let products = response.products
                self?.products.accept(products)
                self?.filteredProducts.accept(products)
                self?.loadingStatus.accept(.success)
                print("ürün data geldi")
            case .failure(let error):
                self?.loadingStatus.accept(.error(error.localizedDescription))
                self?.products.accept(nil)
                print("gelmedi")
            }
        }
    }
    
    
}
