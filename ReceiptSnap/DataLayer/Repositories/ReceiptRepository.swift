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
}

class ReceiptRepository: ReceiptRepositoryProtocol {
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
}
