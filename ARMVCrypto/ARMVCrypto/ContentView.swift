//
//  ContentView.swift
//  ARMVCrypto
//
//  Created by Abhishek on 27/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.cryptoBackground.ignoresSafeArea()
            
            VStack {
                Text("Acesent Color")
                    .foregroundStyle(Color.cryptoAccent)
                    
                Text("Secondary Text Color")
                    .foregroundStyle(.cryptoSecondaryText)
                
                Text("Red Color")
                    .foregroundStyle(.cryptoRed)
                
                Text("Green Color")
                    .foregroundStyle(.cryptoGreen)
                
            }
        }
    }
}

#Preview {
    ContentView()
}
