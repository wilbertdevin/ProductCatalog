//
//  ProductView.swift
//  ProductCatalog
//
//  Created by Wilbert Devin Wijaya on 07/03/24.
//

import SwiftUI

struct ProductView: View {
    @State private var showUploadView = false
    @StateObject var viewModel = ProductController()

    var body: some View {
        
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(viewModel.products) { product in
                        ProductCell(product: product)
                    }
                }
                .padding(.top, 8)
            }
            .navigationTitle("Product")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button(action: {
                        print("Add Product")
                        showUploadView = true
                     
                    }, label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                            .accentColor(.black)
                    })
                    .navigationDestination(isPresented: $showUploadView) {
                        UploadProductView()
                    }
                    
                }
                
            }
            
        }
    }
}

#Preview {
    ProductView()
}
