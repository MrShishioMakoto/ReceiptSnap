//
//  ReceiptError.swift
//  ReceiptSnap
//
//  Created by Gonçalo Almeida on 19/03/2025.
//

import Foundation

enum ReceiptError: Error {
    case noImage
    case invalidImageData
    case invalidAmount
    case storageError(String)

    var localizedDescription: String {
        switch self {
        case .noImage:
            return LocalizableKeys.Capture.noImage
        case .invalidImageData:
            return LocalizableKeys.Capture.invalidImageData
        case .invalidAmount:
            return LocalizableKeys.Capture.invalidAmount
        case .storageError(let message):
            return String.localizedStringWithFormat(LocalizableKeys.Capture.storageError, message)
        }
    }
}
