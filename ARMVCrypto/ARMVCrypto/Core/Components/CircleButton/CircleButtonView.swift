//
//  CircleButtonView.swift
//  ARMVCrypto
//
//  Created by Siri on 28/10/24.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(.cryptoAccent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(.cryptoBackground)
            )
            .shadow(
                color: .cryptoAccent.opacity(0.25),
                radius: 10,
                x: 0,
                y: 0
            )
            .padding()
    }
}

#Preview (traits: .sizeThatFitsLayout) {
    Group {
        CircleButtonView(iconName: "info")
        CircleButtonView(iconName: "plus")
            .colorScheme(.dark)
    }
}
