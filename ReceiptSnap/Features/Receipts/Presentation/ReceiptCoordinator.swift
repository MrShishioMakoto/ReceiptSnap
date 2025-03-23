//
//  ReceiptCoordinator.swift
//  ReceiptSnap
//
//  Created by Gonçalo Almeida on 19/03/2025.
//

import SwiftUI

class ReceiptCoordinator {
    private let repository: ReceiptRepositoryProtocol = ReceiptRepository()
    
    func start() -> some View {
        TabView {
            ReceiptCaptureView(repository: repository)
                .tabItem {
                    Image(systemName: LocalizableKeys.ReceiptCapture.camera)
                    Text(LocalizableKeys.ReceiptCapture.capture)
                }
            
            ReceiptListView(repository: repository)
                .tabItem {
                    Image(systemName: LocalizableKeys.ReceiptList.listBullet)
                    Text(LocalizableKeys.ReceiptList.receipts)
                }
        }
        .tint(.black)
    }
}
