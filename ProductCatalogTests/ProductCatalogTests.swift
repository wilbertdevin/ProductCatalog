//
//  ProductCatalogTests.swift
//  ProductCatalogTests
//
//  Created by Wilbert Devin Wijaya on 07/03/24.
//

import XCTest
@testable import ProductCatalog
import _PhotosUI_SwiftUI
import Firebase

final class ProductCatalogTests: XCTestCase {
    
    func testSearchProduct() {
            // Given
            let viewModel = SearchController()
            let testProducts = [
                Product(id: "1", productName: "Product A", productImageUrl: "TehBotol", productPrice: "10"),
                Product(id: "2", productName: "Product B", productImageUrl: "Fanta", productPrice: "20"),
                Product(id: "3", productName: "Product C", productImageUrl: "CocaCola", productPrice: "30")
            ]
            viewModel.products = testProducts
            
            // When
            viewModel.searchProduct(with: "A")
            
            // Then
            XCTAssertEqual(viewModel.filteredProducts.count, 1)
            XCTAssertEqual(viewModel.filteredProducts[0].productName, "Product A")
            
            // When
            viewModel.searchProduct(with: "Product")
            
            // Then
            XCTAssertEqual(viewModel.filteredProducts.count, 3)
            
            // When
            viewModel.searchProduct(with: "Product C")
            
            // Then
            XCTAssertEqual(viewModel.filteredProducts.count, 1)
            XCTAssertEqual(viewModel.filteredProducts[0].productName, "Product C")
            XCTAssertEqual(viewModel.filteredProducts[0].productImageUrl, "CocaCola")

        }

    func testUploadProduct() {
        // Given
        let viewModel = UploadProductController()
        viewModel.productName = "Test Product"
        viewModel.productPrice = "10000" // Price without currency symbol or separators
        
        // Simulate image selection
        if let image = UIImage(named: "TehBotol") {
            viewModel.selectedImage = PhotosPickerItem(itemIdentifier: "TehBotol")
        } else {
            XCTFail("Failed to create UIImage from image named 'TehBotol'")
            return
        }
        
        let expectation = XCTestExpectation(description: "Upload product expectation")
        
        // When
        Task {
            do {
                try await viewModel.uploadProduct()
                // Fulfill the expectation after successful upload
                expectation.fulfill()
            } catch {
                // Fail the test if an error occurs during upload
                XCTFail("Upload product failed with error: \(error)")
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 5.0) // Adjust the timeout as needed
    }
 
}

