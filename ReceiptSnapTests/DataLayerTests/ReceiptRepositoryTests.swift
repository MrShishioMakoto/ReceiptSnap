//
//  ReceiptRepositoryTests.swift
//  ReceiptSnapTests
//
//  Created by Gonçalo Almeida on 18/03/2025.
//

import XCTest
import RealmSwift
@testable import ReceiptSnap

final class ReceiptRepositoryTests: XCTestCase {
    private var config: Realm.Configuration!

        override func setUp() {
            super.setUp()
            config = Realm.Configuration(inMemoryIdentifier: "TestRealm-\(UUID().uuidString)")
        }
    
    override func tearDown() {
        let realm = try! Realm(configuration: config)
        try! realm.write {
            realm.deleteAll()
        }
        super.tearDown()
    }
    
    func testSaveReceipt() async throws {
        let repository = ReceiptRepository(config: config)
        let newReceipt = MockReceipt.receiptSample
        
        try await repository.saveReceipt(newReceipt)
        let allReceipts = try await repository.fetchAllReceipts()
        
        XCTAssertEqual(allReceipts.count, 1)
        XCTAssertEqual(allReceipts.first?.id, "12345")
        XCTAssertEqual(allReceipts.first?.totalAmount, 12.99)
        XCTAssertEqual(allReceipts.first?.currency, "EUR")
    }
    
    func testFetchAllReceiptsEmpty() async throws {
        let repository = ReceiptRepository()
        
        let allReceipts = try await repository.fetchAllReceipts()
        
        XCTAssertTrue(allReceipts.isEmpty)
    }
    
    func testDeleteReceipt() async throws {
        let repository = ReceiptRepository()
        let newReceipt = MockReceipt.receiptSample
        
        try await repository.saveReceipt(newReceipt)
        
        try await repository.deleteReceipt(newReceipt)
        let allReceipts = try await repository.fetchAllReceipts()
        
        XCTAssertTrue(allReceipts.isEmpty)
    }
}
