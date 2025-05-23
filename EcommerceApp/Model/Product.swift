//
//  Product.swift
//  EcommerceApp
//
//  Created by Beyza Nur Tekerek on 23.05.2025.
//

import Foundation

struct ProductResponse: Decodable {
    let products: [Product]
}

struct Product: Decodable {
    let title: String?
    let description: String?
    let category: String?
    let price: Double?
    let rating: Double?
    let stock: Int?
    let tags: [String]?
    let brand: String?
    let weight: Int?
    let dimensions: Dimensions?
    let warrantyInformation: String?
    let shippingInformation: String?
    let availabilityStatus: String?
    let reviews: [Review]?
    let returnPolicy: String?
    let images: [String]?
    let thumbnail: String?
}

struct Dimensions: Decodable {
    let width: Double?
    let height: Double?
    let depth: Double?
}

struct Review: Decodable {
    let rating: Int?
    let comment: String?
    let date: Date?
    let reviewerName: String?
    let reviewerEmail: String?
}
