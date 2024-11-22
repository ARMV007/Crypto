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
    @State private var showLaunchView: Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.cryptoAccent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.cryptoAccent)]
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack {
                    HomeView()
                        .toolbar(.hidden)
                }
                .environmentObject(viewModel)
                .tint(.cryptoAccent)
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showlaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
                
                
            }
            
            
        }
    }
}
