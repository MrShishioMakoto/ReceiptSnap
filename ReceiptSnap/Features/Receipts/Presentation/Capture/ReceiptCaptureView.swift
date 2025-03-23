//
//  ReceiptCaptureView.swift
//  ReceiptSnap
//
//  Created by Gonçalo Almeida on 18/03/2025.
//

import SwiftUI

struct ReceiptCaptureView: View {
    @StateObject private var viewModel: ReceiptCaptureViewModel
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    
    init(repository: ReceiptRepositoryProtocol) {
        _viewModel = StateObject(wrappedValue: ReceiptCaptureViewModel(repository: repository))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = viewModel.receiptImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 200, height: 200)
                        .border(Color.black, width: 2)
                        .overlay(
                            Text(LocalizableKeys.ReceiptCapture.tapToCapture)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding()
                        )
                        .onTapGesture {
                            showImagePicker = true
                        }
                }
                
                Form {
                    DatePicker(LocalizableKeys.Receipt.date, selection: $viewModel.date, displayedComponents: .date)
                    TextField(LocalizableKeys.Receipt.totalAmount, text: $viewModel.totalAmount)
                        .keyboardType(.decimalPad)
                    TextField(LocalizableKeys.Receipt.currency, text: $viewModel.currency)
                }
                .scrollDisabled(true)
                .scrollContentBackground(.hidden)
                
                Button(LocalizableKeys.ReceiptCapture.saveReceipt) {
                    Task {
                        await viewModel.saveReceipt()
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .padding()
            }
            .navigationTitle(LocalizableKeys.ReceiptCapture.snap)
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $inputImage)
                    .onDisappear {
                        if let inputImage = inputImage {
                            viewModel.receiptImage = inputImage
                        }
                    }
            }
            .alert(item: $viewModel.currentError) { errorItem in
                Alert(
                    title: Text(LocalizableKeys.ReceiptError.errorTitle),
                    message: Text(errorItem.text),
                    dismissButton: .default(Text(LocalizableKeys.ReceiptError.ok))
                )
            }
        }
    }
}

#Preview {
    ReceiptCaptureView(repository: ReceiptRepository())
}
