//
//  MockReceipt.swift
//  ReceiptSnapTests
//
//  Created by Gonçalo Almeida on 20/03/2025.
//

import Foundation
@testable import ReceiptSnap

enum MockReceipt {
    static var receiptSample = Receipt(id: "12345",
                                       date: Date(),
                                       totalAmount: 12.99,
                                       currency: "EUR",
                                       imageData: nil)
    
    static var multipleReceiptsSample = [Receipt(id: "12345",
                                                 date: Date(),
                                                 totalAmount: 12.99,
                                                 currency: "EUR",
                                                 imageData: nil),
                                         Receipt(id: "67891",
                                                 date: Date(),
                                                 totalAmount: 7.5,
                                                 currency: "USD",
                                                 imageData: nil),
                                         Receipt(id: "23456",
                                                 date: Date(),
                                                 totalAmount: 0.87,
                                                 currency: "EUR",
                                                 imageData: nil)]
}
