//
//  ProductService.swift
//  ProductCatalog
//
//  Created by Wilbert Devin Wijaya on 08/03/24.
//

import Foundation
import Firebase

struct ProductService {
    
    static func fetchProduct() async throws -> [Product] {
        let snapshot = try await Firestore.firestore().collection("products").getDocuments()
        return snapshot.documents.compactMap { try? $0.data(as: Product.self) }
        
    }
}
