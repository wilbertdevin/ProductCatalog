//
//  ProductViewModelTests.swift
//  ProductCatalogTests
//
//  Created by Wilbert Devin Wijaya on 08/03/24.
//

import XCTest
import SwiftUI
import FirebaseFirestore
@testable import ProductCatalog

class ProductViewModelTests: XCTestCase {

      var viewModel: ProductController!
      var firestore: Firestore!
      var productsCollection: CollectionReference!
      
    override func setUp() {
        super.setUp()

        firestore = Firestore.firestore()
        productsCollection = firestore.collection("products")
        
        viewModel = ProductController()
    }
      
      override func tearDown() {
          super.tearDown()
          
      }
      
      func testUpdateLikedStatus() {
          // Given
          let productID = "test_product_id"
          let initialIsLiked = true
          
          // Add a sample product document to Firestore
          let productData: [String: Any] = [
              "id": productID,
              "isLiked": initialIsLiked
          ]
          
          let productDocument = productsCollection.document(productID)
          productDocument.setData(productData) { error in
              XCTAssertNil(error, "Error adding document to Firestore: \(error?.localizedDescription ?? "Unknown error")")
              
              // When
              let newIsLiked = !initialIsLiked
              self.viewModel.updateLikedStatus(productID: productID, isLiked: newIsLiked)
              
              // Then
              productDocument.getDocument { documentSnapshot, error in
                  XCTAssertNil(error, "Error fetching document from Firestore: \(error?.localizedDescription ?? "Unknown error")")
                  XCTAssertNotNil(documentSnapshot, "Document snapshot should not be nil")
                  
                  let updatedIsLiked = documentSnapshot?.data()?["isLiked"] as? Bool
                  XCTAssertEqual(updatedIsLiked, newIsLiked, "Liked status in Firestore should be updated to \(newIsLiked)")
                  
              }
          }
      }

}

