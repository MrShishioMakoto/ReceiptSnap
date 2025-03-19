//
//  String+Ext.swift
//  ReceiptSnap
//
//  Created by Gonçalo Almeida on 19/03/2025.
//

import Foundation

extension String {
    func localizable() -> String {
        NSLocalizedString(self, comment: "")
    }
}
