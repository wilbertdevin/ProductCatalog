//
//  SearchView.swift
//  ProductCatalog
//
//  Created by Wilbert Devin Wijaya on 07/03/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchProduct = ""
    @StateObject var viewModel = SearchController()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(viewModel.filteredProducts) { product in
                        HStack {
                            ProductImageView(product: product)
                            
                            VStack(alignment: .leading) {
                                Text(product.productName)
                                    .fontWeight(.semibold)
                                
                                Text(product.productPrice)
                            }
                            .font(.footnote)
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color(.lightGray), radius: 5)
                }
                
                .padding(.top, 8)
                .searchable(text: $searchProduct, prompt: "Search...")
                .onChange(of: searchProduct, perform: { newValue in
                    viewModel.searchProduct(with: newValue)
                })
            }
            .navigationTitle("Search Product")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchView()
}
