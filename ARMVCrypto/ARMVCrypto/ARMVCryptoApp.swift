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
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.cryptoAccent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.cryptoAccent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden)
            }
            .environmentObject(viewModel)        }
    }
}
