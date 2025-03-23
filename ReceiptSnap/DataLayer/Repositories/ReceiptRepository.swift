//
//  ReceiptRepository.swift
//  ReceiptSnap
//
//  Created by Gonçalo Almeida on 18/03/2025.
//

import Foundation
import RealmSwift

protocol ReceiptRepositoryProtocol {
    func saveReceipt(_ receipt: Receipt) async throws
    func fetchAllReceipts() async throws -> [Receipt]
    func deleteReceipt(_ receipt: Receipt) async throws
}

class ReceiptRepository: ReceiptRepositoryProtocol {
    private let config: Realm.Configuration
    
    init(config: Realm.Configuration = Realm.Configuration.defaultConfiguration) {
        self.config = config
    }
    
    func saveReceipt(_ receipt: Receipt) async throws {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global(qos: .background).async {
                do {
                    let realm = try Realm()
                    try realm.write {
                        let realmReceipt = ReceiptRealmObject(receipt: receipt)
                        realm.add(realmReceipt, update: .all)
                    }
                    continuation.resume(returning: ())
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func fetchAllReceipts() async throws -> [Receipt] {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global(qos: .background).async {
                do {
                    let realm = try Realm()
                    let objects = realm.objects(ReceiptRealmObject.self)
                    let receipts = objects.map { $0.toReceipt() }
                    continuation.resume(returning: Array(receipts))
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func deleteReceipt(_ receipt: Receipt) async throws {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global(qos: .background).async {
                do {
                    let realm = try Realm()
                    if let realmReceipt = realm.object(ofType: ReceiptRealmObject.self, forPrimaryKey: receipt.id) {
                        try realm.write {
                            realm.delete(realmReceipt)
                        }
                    }
                    continuation.resume(returning: ())
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
