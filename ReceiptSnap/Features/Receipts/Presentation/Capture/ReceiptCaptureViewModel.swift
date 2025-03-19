//
//  ReceiptCaptureViewModel.swift
//  ReceiptSnap
//
//  Created by Gonçalo Almeida on 18/03/2025.
//

import SwiftUI

class ReceiptCaptureViewModel: ObservableObject {
    @Published var receiptImage: UIImage?
    @Published var date: Date = Date()
    @Published var totalAmount: String = ""
    @Published var currency: String = ""
    
    private let repository: ReceiptRepositoryProtocol
    
    init(repository: ReceiptRepositoryProtocol) {
        self.repository = repository
    }
    
    func saveReceipt() async {
        guard let image = receiptImage,
              let imageData = image.jpegData(compressionQuality: 0.8),
              let totalAmount = Double(totalAmount)
        else { return /* TODO: - Error Handling */ }
        
        let receipt = Receipt(
            id: UUID().uuidString,
            date: date,
            totalAmount: totalAmount,
            currency: currency,
            imageData: imageData
        )
        
        do {
            try await repository.saveReceipt(receipt)
        } catch {
            // TODO: - Error Handling
            print("Error saving receipt: \(error)")
        }
    }
}
