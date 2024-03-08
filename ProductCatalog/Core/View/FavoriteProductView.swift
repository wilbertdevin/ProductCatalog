//
//  FavoriteProductView.swift
//  ProductCatalog
//
//  Created by Wilbert Devin Wijaya on 08/03/24.
//

import SwiftUI
import Firebase

struct FavoriteProductView: View {
    @State private var showUploadView = false
    @StateObject var viewModel = ProductController()

    var body: some View {
        
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(viewModel.products.filter { $0.isLiked ?? false }) { product in
                        ProductCell(product: product)
                    }
                }
                .padding(.top, 8)
            }
            .navigationTitle("Favorite Product")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

#Preview {
    FavoriteProductView()
}
