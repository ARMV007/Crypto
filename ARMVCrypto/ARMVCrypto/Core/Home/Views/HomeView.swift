//
//  HomeView.swift
//  ARMVCrypto
//
//  Created by Abhishek on 28/10/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var showPortfolio: Bool = false
    
    
    var body: some View {
        ZStack {
            Color.cryptoBackground.ignoresSafeArea()
            VStack {
                homeHeader
                
                columnTitles
                
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                
                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
               
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
    .environmentObject(DeveloperPreview.instance.homeVM)
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
    
    private var allCoinsList: some View {
        List {
            ForEach(viewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(.cryptoSecondaryText)
        .padding(.horizontal)
    }
}
