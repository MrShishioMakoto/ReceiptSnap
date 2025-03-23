//
//  DateFormatter+Ext.swift
//  ReceiptSnap
//
//  Created by Gonçalo Almeida on 19/03/2025.
//

import Foundation

extension DateFormatter {
    static let shortDate: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateStyle = .short
       return formatter
    }()
}
