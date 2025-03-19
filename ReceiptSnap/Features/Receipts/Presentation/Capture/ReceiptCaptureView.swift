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
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 300)
                    .border(Color.black, width: 2)
                    .overlay(
                        Text(LocalizableKeys.Capture.tapToCapture)
                            .font(.title)
                            .fontWeight(.bold)
                    )
                    .onTapGesture {
                        showImagePicker = true
                    }
                    .padding()
                
                Form {
                    DatePicker(LocalizableKeys.Capture.date, selection: $viewModel.date, displayedComponents: .date)
                    TextField(LocalizableKeys.Capture.totalAmount, text: $viewModel.totalAmount)
                        .keyboardType(.decimalPad)
                    TextField(LocalizableKeys.Capture.currency, text: $viewModel.currency)
                }
                .scrollDisabled(true)
                .scrollContentBackground(.hidden)
                
                Button(LocalizableKeys.Capture.saveReceipt) {
                    Task {
                        await viewModel.saveReceipt()
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .padding()
            }
            .navigationTitle(LocalizableKeys.Capture.snap)
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
                    title: Text(LocalizableKeys.Capture.errorTitle),
                    message: Text(errorItem.text),
                    dismissButton: .default(Text(LocalizableKeys.Capture.ok))
                )
            }
        }
    }
}

#Preview {
    ReceiptCaptureView(repository: ReceiptRepository())
}
