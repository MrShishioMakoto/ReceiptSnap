//
//  ReceiptCaptureView.swift
//  ReceiptSnap
//
//  Created by Gonçalo Almeida on 18/03/2025.
//

import SwiftUI

struct ReceiptCaptureView: View {
    @StateObject private var viewModel = ReceiptCaptureViewModel()
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        NavigationView {
            VStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 300)
                    .border(Color.black, width: 2)
                    .overlay(
                        Text("Tap to capture a photo of your receipt.")
                            .font(.title)
                            .fontWeight(.bold)
                    )
                    .onTapGesture {
                        showImagePicker = true
                    }
                    .padding()
                
                Form {
                    DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
                    TextField("Total Amount", text: $viewModel.totalAmount)
                        .keyboardType(.decimalPad)
                    TextField("Currency", text: $viewModel.currency)
                }
            }
            .navigationTitle("Snap")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $inputImage)
                    .onDisappear {
                        if let inputImage = inputImage {
                            viewModel.receiptImage = inputImage
                        }
                    }
            }
        }
    }
}

#Preview {
    ReceiptCaptureView()
}
