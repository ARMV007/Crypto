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
    @State private var showProtfolioView: Bool = false
    @State private var showSettingView: Bool = false
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailsView: Bool = false
    
    
    var body: some View {
        ZStack {
            Color.cryptoBackground
                .ignoresSafeArea()
            VStack {
                homeHeader
                HomeStatView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $viewModel.searchText)
                columnTitles
                
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                
                if showPortfolio {
                    ZStack(alignment: .top) {
                        if viewModel.portfolioCoins.isEmpty && viewModel.searchText.isEmpty {
                            portfolioEmptyText
                        } else {
                            portfolioCoinsList
                        }
                    }
                        .transition(.move(edge: .trailing))
                }
               
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showSettingView) {
                SettingsView()
            }
        }
        .sheet(isPresented: $showProtfolioView) {
            PortfolioView()
                .environmentObject(viewModel)
        }
        .navigationDestination(isPresented: $showDetailsView) {
            if let selectedCoin {
                DetailView(coin: selectedCoin)
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
                .onTapGesture {
                    if showPortfolio {
                        showProtfolioView.toggle()
                    } else {
                        showSettingView.toggle()
                    }
                }
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
                    .onTapGesture {
                        segue(coin: coin)
                    }
                    .listRowBackground(Color.cryptoBackground)
            }
        }
        .listStyle(.plain)
        .refreshable {
            if !viewModel.isLoading {
                viewModel.reloadData()
            }
        }
    }
    
    private var portfolioEmptyText: some View {
        Text("You haven't added any coins to your portfolio yet! Click + icon to get started 🧐")
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.cryptoAccent)
            .multilineTextAlignment(.center)
            .padding(50)
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
                    .listRowBackground(Color.cryptoBackground)
            }
        }
        .listStyle(.plain)
        .refreshable {
            if !viewModel.isLoading {
                viewModel.reloadData()
            }
        }
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailsView = true
    }
    
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .rank || viewModel.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = (viewModel.sortOption == .rank) ? .rankReversed : .rank
                }
            }
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((viewModel.sortOption == .holdings || viewModel.sortOption == .holdingReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        viewModel.sortOption = (viewModel.sortOption == .holdings) ? .holdingReversed : .holdings
                    }
                }
            }
            
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .price || viewModel.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = (viewModel.sortOption == .price) ? .priceReversed : .price
                }
                
            }
           
        }
        .font(.caption)
        .foregroundStyle(.cryptoSecondaryText)
        .padding(.horizontal)
    }
}
