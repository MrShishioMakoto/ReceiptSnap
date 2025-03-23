//
//  ReceiptListView.swift
//  ReceiptSnap
//
//  Created by Gonçalo Almeida on 19/03/2025.
//

import SwiftUI

struct ReceiptListView: View {
    @StateObject private var viewModel: ReceiptListViewModel
    
    init(repository: ReceiptRepositoryProtocol) {
        _viewModel = StateObject(wrappedValue: ReceiptListViewModel(repository: repository))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.receipts, id: \.id) { receipt in
                    HStack {
                        if let data = receipt.imageData,
                           let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(4)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(LocalizableKeys.Receipt.date): \(receipt.date, formatter: DateFormatter.shortDate)")
                            Text("\(LocalizableKeys.Receipt.totalAmount): \(receipt.totalAmount, specifier: "%.2f") \(receipt.currency)")
                        }
                    }
                }
                .onDelete { indexSet in
                    Task {
                        for index in indexSet {
                            let receipt = viewModel.receipts[index]
                            await viewModel.deleteReceipt(receipt)
                        }
                    }
                }
            }
            .navigationTitle(LocalizableKeys.ReceiptList.receipts)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                Task {
                    await viewModel.loadReceipts()
                }
            }
        }
    }
}

#Preview {
    ReceiptListView(repository: ReceiptRepository())
}
