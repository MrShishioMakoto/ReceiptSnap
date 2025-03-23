//
//  ReceiptCaptureViewModelTests.swift
//  ReceiptSnapTests
//
//  Created by Gonçalo Almeida on 20/03/2025.
//

import XCTest
import SwiftUI
@testable import ReceiptSnap

final class ReceiptCaptureViewModelTests: XCTestCase {
    func testSaveReceiptSuccess() async {
        let mockRepository = MockReceiptRepository()
        let viewModel = ReceiptCaptureViewModel(repository: mockRepository)
        
        viewModel.receiptImage = UIImage(systemName: "camera.fill")
        viewModel.totalAmount = "11.1"
        viewModel.currency = "EUR"
        
        await viewModel.saveReceipt()
        
        XCTAssertTrue(mockRepository.saveReceiptCalled)
        XCTAssertNil(viewModel.currentError)
    }
    
    func testSaveReceiptNoImage() async {
        let mockRepository = MockReceiptRepository()
        let viewModel = ReceiptCaptureViewModel(repository: mockRepository)
        
        viewModel.totalAmount = "11.1"
        viewModel.currency = "EUR"
        
        await viewModel.saveReceipt()
        
        XCTAssertFalse(mockRepository.saveReceiptCalled)
        XCTAssertNotNil(viewModel.currentError)
        XCTAssertEqual(viewModel.currentError?.text, ReceiptError.noImage.localizedDescription)
    }
    
    func testSaveReceiptInvalidImageData() async {
        let mockRepository = MockReceiptRepository()
        let viewModel = ReceiptCaptureViewModel(repository: mockRepository)
        
        viewModel.receiptImage = UIImage()
        viewModel.totalAmount = "11.1"
        viewModel.currency = "EUR"
        
        await viewModel.saveReceipt()
        
        XCTAssertFalse(mockRepository.saveReceiptCalled)
        XCTAssertNotNil(viewModel.currentError)
        XCTAssertEqual(viewModel.currentError?.text, ReceiptError.invalidImageData.localizedDescription)
    }
    
    func testSaveReceiptInvalidAmount() async {
        let mockRepository = MockReceiptRepository()
        let viewModel = ReceiptCaptureViewModel(repository: mockRepository)
        
        viewModel.receiptImage = UIImage(systemName: "camera.fill")
        viewModel.totalAmount = "abc"
        viewModel.currency = "EUR"
        
        await viewModel.saveReceipt()
        
        XCTAssertFalse(mockRepository.saveReceiptCalled)
        XCTAssertNotNil(viewModel.currentError)
        XCTAssertEqual(viewModel.currentError?.text, ReceiptError.invalidAmount.localizedDescription)
    }
    
    func testSaveReceiptRepositoryError() async {
        let mockRepository = MockReceiptRepository()
        let viewModel = ReceiptCaptureViewModel(repository: mockRepository)
        
        viewModel.receiptImage = UIImage(systemName: "camera.fill")
        viewModel.totalAmount = "11.1"
        viewModel.currency = "EUR"
        
        mockRepository.errorToThrow = NSError(domain: "TestError", code: 123, userInfo: nil)
        
        await viewModel.saveReceipt()
        
        XCTAssertTrue(mockRepository.saveReceiptCalled)
        XCTAssertNotNil(viewModel.currentError)
        let expectedPrefix = ReceiptError.storageError("").localizedDescription.components(separatedBy: ":").first ?? ""
        XCTAssertTrue(viewModel.currentError?.text.contains(expectedPrefix) == true,
                      "Expected a storageError message.")
    }
}

