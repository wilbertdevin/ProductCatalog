//
//  ProductViewModel.swift
//  ProductCatalog
//
//  Created by Wilbert Devin Wijaya on 08/03/24.
//

import SwiftUI
import Firebase

class ProductController: ObservableObject {
    @Published var products = [Product]()
    
    private let db = Firestore.firestore()
    
    init() {
        fetchProducts()
    }
    
    func fetchProducts() {
        db.collection("products").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            self.products = documents.compactMap { document -> Product? in
                do {
                    return try document.data(as: Product.self)
                } catch {
                    print("Error decoding product document: \(error)")
                    return nil
                }
            }
        }
    }
    
    func updateLikedStatus(productID: String, isLiked: Bool) {
        let productRef = db.collection("products").document(productID)
        productRef.updateData(["isLiked": isLiked])
    }
}
