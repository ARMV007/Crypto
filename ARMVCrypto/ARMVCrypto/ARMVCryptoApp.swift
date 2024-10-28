//
//  ARMVCryptoApp.swift
//  ARMVCrypto
//
//  Created by Abhishek on 27/10/24.
//

import SwiftUI

@main
struct ARMVCryptoApp: App {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .toolbar(.hidden)
            }
            .environmentObject(viewModel)        }
    }
}
