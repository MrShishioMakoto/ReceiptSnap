//
//  ReceiptListViewModel.swift
//  ReceiptSnap
//
//  Created by Gonçalo Almeida on 19/03/2025.
//

import SwiftUI

class ReceiptListViewModel: ObservableObject {
    @Published var receipts: [Receipt] = []
    
    private let repository: ReceiptRepositoryProtocol
    
    init(repository: ReceiptRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadReceipts() async {
        do {
            let fetchedReceipts = try await repository.fetchAllReceipts()
            await MainActor.run {
                self.receipts = fetchedReceipts
            }
        } catch {
            print("Error fetching receipts: \(error)")
        }
    }
    
    func deleteReceipt(_ receipt: Receipt) async {
        guard let index = receipts.firstIndex(where: { $0.id == receipt.id }) else { return }
        let removedReceipt = receipts.remove(at: index)
        
        do {
            try await repository.deleteReceipt(receipt)
        } catch {
            await MainActor.run {
                self.receipts.insert(removedReceipt, at: index)
            }
            print("Error deleting receipt: \(error)")
        }
    }
}
