//
//  Product.swift
//  ProductCatalog
//
//  Created by Wilbert Devin Wijaya on 07/03/24.
//

import Foundation

struct Product: Identifiable, Codable {
    let id: String
    var productName: String
    var productImageUrl: String?
    let productPrice: String
    var isLiked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case productName
        case productImageUrl
        case productPrice
        case isLiked 
    }
    
    init(id: String, productName: String, productImageUrl: String?, productPrice: String, isLiked: Bool? = nil) {
        self.id = id
        self.productName = productName
        self.productImageUrl = productImageUrl
        self.productPrice = productPrice
        self.isLiked = isLiked
    }
}

extension Product {
    static var MOCK_PRODUCTS: [Product] = [
        .init(id: NSUUID().uuidString, productName: "Teh Botol", productImageUrl: nil, productPrice: "Rp 5.000"),
        .init(id: NSUUID().uuidString, productName: "Fanta", productImageUrl: nil, productPrice: "Rp 4.000"),
        .init(id: NSUUID().uuidString, productName: "Coca Cola", productImageUrl: nil, productPrice: "Rp 7.500"),
        .init(id: NSUUID().uuidString, productName: "Sprite", productImageUrl: nil, productPrice: "Rp 7.500"),
        .init(id: NSUUID().uuidString, productName: "Pepsi", productImageUrl: nil, productPrice: "Rp 25.000"),

    ]
}
