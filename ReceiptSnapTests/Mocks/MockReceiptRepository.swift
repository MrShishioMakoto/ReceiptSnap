//
//  MockReceiptRepository.swift
//  ReceiptSnapTests
//
//  Created by Gonçalo Almeida on 20/03/2025.
//

import Foundation
@testable import ReceiptSnap

class MockReceiptRepository: ReceiptRepositoryProtocol {
    private(set) var saveReceiptCalled = false
    private(set) var fetchAllReceiptsCalled = false
    private(set) var deleteReceiptCalled = false

    var receipts: [Receipt] = []
    var errorToThrow: Error?

    func saveReceipt(_ receipt: Receipt) async throws {
        saveReceiptCalled = true
        if let error = errorToThrow {
            throw error
        }
        receipts.append(receipt)
    }

    func fetchAllReceipts() async throws -> [Receipt] {
        fetchAllReceiptsCalled = true
        if let error = errorToThrow {
            throw error
        }
        return receipts
    }

    func deleteReceipt(_ receipt: Receipt) async throws {
        deleteReceiptCalled = true
        if let error = errorToThrow {
            throw error
        }
        receipts.removeAll { $0.id == receipt.id }
    }
}
