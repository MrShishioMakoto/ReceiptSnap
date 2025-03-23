//
//  ReceiptListViewModelTests.swift
//  ReceiptSnapTests
//
//  Created by Gonçalo Almeida on 20/03/2025.
//

import XCTest
@testable import ReceiptSnap

final class ReceiptListViewModelTests: XCTestCase {
    func testLoadReceiptsSuccess() async {
        let mockRepository = MockReceiptRepository()
        mockRepository.receipts = MockReceipt.multipleReceiptsSample
        let viewModel = ReceiptListViewModel(repository: mockRepository)
        
        await viewModel.loadReceipts()
        
        XCTAssertTrue(mockRepository.fetchAllReceiptsCalled)
        XCTAssertEqual(viewModel.receipts.count, 3)
        XCTAssertEqual(viewModel.receipts.first?.id, "12345")
        XCTAssertEqual(viewModel.receipts.last?.id, "23456")
    }
    
    func testLoadReceiptsError() async {
        let mockRepository = MockReceiptRepository()
        mockRepository.errorToThrow = NSError(domain: "TestError", code: 999)
        let viewModel = ReceiptListViewModel(repository: mockRepository)
        
        await viewModel.loadReceipts()
        
        XCTAssertTrue(mockRepository.fetchAllReceiptsCalled)
        XCTAssertTrue(viewModel.receipts.isEmpty)
    }
    
    func testDeleteReceiptSuccess() async {
        let mockRepository = MockReceiptRepository()
        mockRepository.receipts = MockReceipt.multipleReceiptsSample
        let viewModel = ReceiptListViewModel(repository: mockRepository)
        
        await viewModel.loadReceipts()
        
        let toDelete = MockReceipt.multipleReceiptsSample.first!
        await viewModel.deleteReceipt(toDelete)
        
        XCTAssertTrue(mockRepository.deleteReceiptCalled)
        XCTAssertEqual(viewModel.receipts.count, 2)
        XCTAssertFalse(viewModel.receipts.contains { $0.id == toDelete.id })
    }
    
    func testDeleteReceiptError() async {
        let mockRepository = MockReceiptRepository()
        mockRepository.receipts = MockReceipt.multipleReceiptsSample
        let viewModel = ReceiptListViewModel(repository: mockRepository)
        
        await viewModel.loadReceipts()
        
        mockRepository.errorToThrow = NSError(domain: "TestError", code: 1)
        
        let toDelete = MockReceipt.multipleReceiptsSample.first!
        await viewModel.deleteReceipt(toDelete)
        
        XCTAssertTrue(mockRepository.deleteReceiptCalled)
        XCTAssertEqual(viewModel.receipts.count, 3)
    }

}
