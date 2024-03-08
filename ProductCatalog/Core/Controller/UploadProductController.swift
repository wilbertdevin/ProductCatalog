//
//  UploadProductViewModel.swift
//  ProductCatalog
//
//  Created by Wilbert Devin Wijaya on 07/03/24.
//

import Foundation
import PhotosUI
import SwiftUI

//@MainActor
class UploadProductController: ObservableObject {
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    
    @Published var productImage: Image?
    
    @Published var productName = ""
    @Published var productPrice = ""
    
    private var uiImage: UIImage?

    // Number formatter for currency formatting
    private let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id_ID") // Set locale to Indonesia
        return formatter
    }()
    
    // Computed property for the formatted product price
    var formattedPrice: String {
        get {
            // Convert product price to number, then format as currency
            let price = Double(productPrice) ?? 0
            return currencyFormatter.string(from: NSNumber(value: price)) ?? ""
        }
        set {
            // Strip currency symbol and thousand separators before setting
            productPrice = newValue.replacingOccurrences(of: currencyFormatter.currencySymbol ?? "", with: "").replacingOccurrences(of: currencyFormatter.groupingSeparator ?? "", with: "")
        }
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        
        self.uiImage = uiImage
        self.productImage = Image(uiImage: uiImage)
    }
    
    func uploadProduct() async throws {

        guard let uiImage = uiImage else { return }
        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { return }
        
        // Format product price string with thousand separators
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        // Convert product price string to NSNumber for formatting
        guard let priceNumber = formatter.number(from: productPrice) else {
            return
        }
        let formattedPrice = formatter.string(from: priceNumber) ?? ""

        try await AuthService.shared.uploadUserData(productName: productName, productPrice: "Rp \(formattedPrice)", productImageUrl: imageUrl)
    }
    
}
