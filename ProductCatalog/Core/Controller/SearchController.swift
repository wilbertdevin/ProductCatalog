//
//  SearchViewModel.swift
//  ProductCatalog
//
//  Created by Wilbert Devin Wijaya on 08/03/24.
//

import Foundation

class SearchController: ObservableObject {
    @Published var products = [Product]()
    @Published var filteredProducts = [Product]() // Add filteredProducts property
    
    init() {
        Task { try await fetchProduct() }
    }
    
    @MainActor
    func fetchProduct() async throws {
        self.products = try await ProductService.fetchProduct()
        self.filteredProducts = self.products // Initialize filteredProducts with all products initially
    }
    
    func searchProduct(with searchText: String) {
        if searchText.isEmpty {
            filteredProducts = products // If search text is empty, show all products
        } else {
            filteredProducts = products.filter { $0.productName.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
