//
//  HomeViewModel.swift
//  ARMVCrypto
//
//  Created by Abhishek on 28/10/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [Statistic] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOption = .holdings
    
    private let dataService = CoinDataService()
    private let marketDataSerive = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingReversed, price, priceReversed
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // update all coins
        $searchText
            .combineLatest(dataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .map(filterAndSortCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // update Portfolio data
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinToPortfolioCoins)
            .sink { [weak self] (returnedValues) in
                guard let self = self else { return }
                self.portfolioCoins = self.shortPortfolioCoinIfNeeded(coins: returnedValues)
            }
            .store(in: &cancellables)
        
        // update market data
        marketDataSerive.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
        
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePorfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        dataService.getCoins()
        marketDataSerive.getMarketData()
    }
    
    private func mapAllCoinToPortfolioCoins(coins: [CoinModel], entities: [PortfolioEntity]) -> [CoinModel] {
        coins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = entities.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    private func filterAndSortCoins(text: String, coins: [CoinModel], sortOption: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(coins: &updatedCoins, sortOption: sortOption)
        return updatedCoins
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        return coins.filter { coin in
            coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func sortCoins(coins: inout [CoinModel], sortOption: SortOption) {
        switch sortOption {
        case .rank, .holdings:
            coins.sort { $0.rank < $1.rank }
        case .rankReversed, .holdingReversed:
            coins.sort { $0.rank > $1.rank }
        case .price:
            coins.sort { $0.currentPrice > $1.currentPrice }
        case .priceReversed:
            coins.sort { $0.currentPrice < $1.currentPrice }
        }
    }
    
    private func shortPortfolioCoinIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        // only sort by holding and reversedHoldings if needed
        switch sortOption {
        case .holdings:
            return coins.sorted { $0.currentHoldingsValue > $1.currentHoldingsValue }
        case .holdingReversed:
            return coins.sorted { $0.currentHoldingsValue < $1.currentHoldingsValue }
        default:
            return coins
        }
    }
    
    private func mapGlobalMarketData(marketData: MarketData?, portfolioCoins: [CoinModel]) -> [Statistic] {
        var stats: [Statistic] = []
        
        guard let data = marketData else {
            return stats
        }
        
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24h Volume", value: data.volume)
        let btcDominace = Statistic(title: "BTC Dominance", value: data.btcDominace)
        let portfolioValue = portfolioCoins.map ({ $0.currentHoldingsValue }).reduce( 0, +)
        let previousValue =
        portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce( 0, +)
        
        let percentChange = ((portfolioValue - previousValue) / previousValue) * 100
        let portfolio = Statistic(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentChange)
        
        stats.append(contentsOf: [marketCap, volume, btcDominace, portfolio])
        return stats
    }
}
