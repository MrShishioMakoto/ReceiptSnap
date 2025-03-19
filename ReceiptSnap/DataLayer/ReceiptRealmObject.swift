//
//  ReceiptRealmObject.swift
//  ReceiptSnap
//
//  Created by Gonçalo Almeida on 18/03/2025.
//

import Foundation
import RealmSwift

class ReceiptRealmObject: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var date: Date = Date()
    @objc dynamic var totalAmount: Double = 0
    @objc dynamic var currency: String = ""
    @objc dynamic var imageData: Data? = nil
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(receipt: Receipt) {
        self.init()
        self.id = receipt.id
        self.date = receipt.date
        self.totalAmount = receipt.totalAmount
        self.currency = receipt.currency
        self.imageData = receipt.imageData
    }
    
    func toReceipt() -> Receipt {
        return Receipt(
            id: self.id,
            date: self.date,
            totalAmount: self.totalAmount,
            currency: self.currency,
            imageData: self.imageData
        )
    }
}
