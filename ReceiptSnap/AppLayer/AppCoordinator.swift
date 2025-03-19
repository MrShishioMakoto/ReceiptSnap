//
//  AppCoordinator.swift
//  ReceiptSnap
//
//  Created by Gonçalo Almeida on 19/03/2025.
//

import SwiftUI

class AppCoordinator: ObservableObject {
    private let receiptCoordinator = ReceiptCoordinator()
    
    func start() -> some View {
        return receiptCoordinator.start()
    }
}
