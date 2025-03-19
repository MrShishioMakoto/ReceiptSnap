//
//  ReceiptSnapApp.swift
//  ReceiptSnap
//
//  Created by Gonçalo Almeida on 18/03/2025.
//

import SwiftUI

@main
struct ReceiptSnapApp: App {
    @StateObject private var appCoordinator = AppCoordinator()
    var body: some Scene {
        WindowGroup {
            appCoordinator.start()
        }
    }
}
