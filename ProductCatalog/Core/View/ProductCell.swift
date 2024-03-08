//
//  ProductCell.swift
//  ProductCatalog
//
//  Created by Wilbert Devin Wijaya on 07/03/24.
//

import SwiftUI
import Firebase

struct ProductCell: View {
    let product: Product
    @State private var isLiked: Bool
    
    @StateObject private var viewModel = ProductController()
    
    init(product: Product) {
        self.product = product
        self._isLiked = State(initialValue: product.isLiked ?? false)
    }
    
    var body: some View {
        HStack {
            ProductImageView(product: product)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(product.productName)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(product.productPrice)
                    .font(.caption)
                    .fontWeight(.light)
            }
            Spacer()
            
            Button(action: {
                isLiked.toggle()
                viewModel.updateLikedStatus(productID: product.id, isLiked: isLiked)
            }, label: {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 30, height: 30)
                                    .accentColor(isLiked ? .red : .black)
                                    .padding(.trailing, 25)
            })
        }
                .background(Color(.white))
                .cornerRadius(20)
                .shadow(color: Color(.lightGray), radius: 5)
    }
    
}


#Preview {
    ProductCell(product: Product.MOCK_PRODUCTS[2])
}
