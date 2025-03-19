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
                    Image(systemName: LocalizableKeys.Capture.camera)
                    Text(LocalizableKeys.Capture.capture)
                }
        }
        .tint(.black)
    }
}
