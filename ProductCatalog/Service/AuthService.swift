//
//  AuthService.swift
//  ProductCatalog
//
//  Created by Wilbert Devin Wijaya on 07/03/24.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase
import PhotosUI

class AuthService {
    
    static let shared = AuthService()

    func uploadUserData(productName: String, productPrice: String, productImageUrl: String) async {
    
        let product = Product(id: NSUUID().uuidString, productName: productName, productImageUrl: productImageUrl, productPrice: productPrice)

        guard let encodedUser = try? Firestore.Encoder().encode(product) else { return }
        
        try? await Firestore.firestore().collection("products").document(product.id).setData(encodedUser)
    }
    
}
