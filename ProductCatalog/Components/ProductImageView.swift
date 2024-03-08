//
//  ProductImageView.swift
//  ProductCatalog
//
//  Created by Wilbert Devin Wijaya on 08/03/24.
//

import SwiftUI
import Kingfisher

struct ProductImageView: View {
    let product: Product
    
    var body: some View {
        if let imageUrl = product.productImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .foregroundColor(Color(.systemGray4))
        }
        
    }
}

#Preview {
    ProductImageView(product: Product.MOCK_PRODUCTS[2])
}
