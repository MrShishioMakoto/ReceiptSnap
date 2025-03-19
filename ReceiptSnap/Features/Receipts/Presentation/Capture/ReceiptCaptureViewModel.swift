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
    
    @Published var currentError: ErrorMessage?
    
    private let repository: ReceiptRepositoryProtocol
    
    init(repository: ReceiptRepositoryProtocol) {
        self.repository = repository
    }
    
    func saveReceipt() async {
        do {
            try await validateAndSaveReceipt()
        } catch let error as ReceiptError {
            await MainActor.run {
                self.currentError = ErrorMessage(text: error.localizedDescription)
            }
        } catch {
            await MainActor.run {
                self.currentError = ErrorMessage(text: error.localizedDescription)
            }
        }
    }
    
    private func validateAndSaveReceipt() async throws {
        guard let image = receiptImage
        else { throw ReceiptError.noImage }
        
        guard let imageData = image.jpegData(compressionQuality: 0.8)
        else { throw ReceiptError.invalidImageData }
        
        guard let totalAmount = Double(totalAmount)
        else { throw ReceiptError.invalidAmount }
        
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
            throw ReceiptError.storageError(error.localizedDescription)
        }
    }
}
