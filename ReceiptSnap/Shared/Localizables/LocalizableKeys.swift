//
//  LocalizableKeys.swift
//  ReceiptSnap
//
//  Created by Gonçalo Almeida on 19/03/2025.
//

import Foundation

enum LocalizableKeys {
    
    enum Receipt {
        static let date = "receipt_capture_date".localizable()
        static let totalAmount = "receipt_capture_total_amount".localizable()
        static let currency = "receipt_capture_currency".localizable()
    }
    
    enum ReceiptCapture {
        static let tapToCapture = "receipt_capture_tap_to_capture".localizable()
        static let snap = "receipt_capture_snap".localizable()
        static let saveReceipt = "receipt_capture_save_receipt".localizable()
        static let capture = "receipt_capture_capture".localizable()
        static let camera = "receipt_capture_camera".localizable()
    }
    
    enum ReceiptList {
        static let listBullet = "receipt_list_list_bullet".localizable()
        static let receipts = "receipt_list_receipts".localizable()
    }
    
    enum ReceiptError {
        static let errorTitle = "receipt_capture_error_title".localizable()
        static let ok = "receipt_capture_ok".localizable()
        static let noImage = "receipt_capture_no_image".localizable()
        static let invalidImageData = "receipt_capture_invalid_image_data".localizable()
        static let invalidAmount = "receipt_capture_invalid_amount".localizable()
        static let storageError = "receipt_capture_storage_error".localizable()
    }
}
