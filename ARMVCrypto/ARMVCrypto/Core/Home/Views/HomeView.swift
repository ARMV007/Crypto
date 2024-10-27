//
//  HomeView.swift
//  ARMVCrypto
//
//  Created by Siri on 28/10/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.cryptoBackground.ignoresSafeArea()
            
            VStack {
                Text("Header")
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
            .toolbar(.hidden)
    }
}
