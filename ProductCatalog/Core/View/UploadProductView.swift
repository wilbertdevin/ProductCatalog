//
//  UploadProductView.swift
//  ProductCatalog
//
//  Created by Wilbert Devin Wijaya on 07/03/24.
//

import SwiftUI
import PhotosUI

struct UploadProductView: View {
    
    @State private var productName = ""
    @State private var productPrice = ""
    @State private var imagePicker = false
    @StateObject var viewModel = UploadProductController()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>    
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    print("Cancel Upload")
                    self.presentationMode.wrappedValue.dismiss()
                    
                }, label: {
                    Text("Cancel")
                })
                
                Spacer()
                
                Text("New Product")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button(action: {
                    Task { try await viewModel.uploadProduct() }
                    self.presentationMode.wrappedValue.dismiss()

                }, label: {
                    Text("Upload")
                })
                .disabled(viewModel.productName.isEmpty || viewModel.productPrice.isEmpty)
                
            }
            .padding(.horizontal)
            
            HStack(spacing: 8) {
                if let image = viewModel.productImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipped()
                        .padding(.leading)
                }
                VStack {
                    TextField("Enter Product Name", text: $viewModel.productName, axis: .vertical)
                        .padding()
                        .frame(width: 250, height: 50)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(5)
                    

                    TextField("Enter Product Price", text: $viewModel.formattedPrice, axis: .vertical)
                        .padding()
                        .frame(width: 250, height: 50)
                        .keyboardType(.numberPad)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(5)

                }
                .font(.caption)
                .padding(.trailing)

            }
            .padding()
            
            Spacer()
        }
        .onAppear(perform: {
            imagePicker.toggle()
        })
        .photosPicker(isPresented: $imagePicker, selection: $viewModel.selectedImage)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    UploadProductView()
}
