//
//  ProdcutListReponse.swift
//  BagzzDemoApp
//
//  Created by Gopu on 05/02/24.
//

import Foundation

// MARK: - ProductListResponseElement
struct ProductListResponseElement: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}

typealias ProductListResponse = [ProductListResponseElement]
