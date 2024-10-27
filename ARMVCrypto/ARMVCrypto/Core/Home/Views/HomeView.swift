//
//  HomeView.swift
//  ARMVCrypto
//
//  Created by Abhishek on 28/10/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack {
            Color.cryptoBackground.ignoresSafeArea()
            VStack {
                homeHeader
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

extension HomeView {
    
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            
            Text(showPortfolio ? "Portfolio" : "Live Price")
                .font(.headline)
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.cryptoAccent)
            
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}
