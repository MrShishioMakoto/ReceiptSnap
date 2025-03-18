//
//  Receipt.swift
//  ReceiptSnap
//
//  Created by Gonçalo Almeida on 18/03/2025.
//

import Foundation

struct Receipt: Identifiable {
    let id: String
    let date: Date
    let totalAmount: Double
    let currency: String
    let imageData: Data?
}
