//
//  ProductFavoriteViewTests.swift
//  ProductCatalogTests
//
//  Created by Wilbert Devin Wijaya on 08/03/24.
//
 
import XCTest
@testable import ProductCatalog

class FavoriteProductViewTests: XCTestCase {

    func testProductIsLiked() {
        // Given
        let viewModel = ProductViewModelMock()
        let productA = Product(id: "1", productName: "Product A", productImageUrl: "TehBotol", productPrice: "Rp 20.000", isLiked: true)
        let productB = Product(id: "2", productName: "Product B", productImageUrl: "TehBotol", productPrice: "Rp 20.000", isLiked: false)
        let productC = Product(id: "3", productName: "Product C", productImageUrl: "TehBotol", productPrice: "Rp 20.000", isLiked: true)
        viewModel.products = [productA, productB, productC]
        
        // When
        let favoriteProductView = FavoriteProductView(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(favoriteProductView.viewModel.products.filter { $0.isLiked == true }.count, 2)
        XCTAssertEqual(favoriteProductView.viewModel.products.filter { $0.isLiked == false }.count, 1)
    }
}

// Mock ViewModel for testing
class ProductViewModelMock: ProductController {
    override func fetchProducts() {

    }
}
