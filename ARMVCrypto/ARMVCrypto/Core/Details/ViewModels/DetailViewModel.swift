//
//  DetailViewModel.swift
//  ARMVCrypto
//
//  Created by Abhishek on 04/11/24.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    @Published var overviewStatistic: [Statistic] = []
    @Published var additionalStatistic: [Statistic] = []
    private let coinDetailsService: CoinDetailsDataService
    @Published var coin: CoinModel
    private var cancelable = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailsService = CoinDetailsDataService(coin: coin)
        addSubscriber()
    }
    
    private func addSubscriber() {
        coinDetailsService.$coinDetail
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink {[weak self] retrunedArrays in
                self?.overviewStatistic = retrunedArrays.overview
                self?.additionalStatistic = retrunedArrays.additional
            }
            .store(in: &cancelable)
    }
    
    private func mapDataToStatistics(coinDetails: CoinDetail?, coin: CoinModel) -> (overview: [Statistic], additional: [Statistic]) {
       
        let overviewArray = createOverviewArray(coin: coin)
        let additionalArray = crateAdditionalArray(coinDetails: coinDetails, coin: coin)
        
        return(overviewArray, additionalArray)
    }
    
    private func createOverviewArray(coin: CoinModel) -> [Statistic] {
        // Overview
        let price = coin.currentPrice.asCurrencyWith6Decimals()
        let pricePercentChange = coin.priceChangePercentage24H
        let priceStat = Statistic(title: "Current price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapStat = Statistic(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = "\(coin.rank)"
        let rankStat = Statistic(title: "Rank", value: rank)
        
        let volume = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = Statistic(title: "Volume", value: volume)
        
        return [priceStat, marketCapStat, rankStat, volumeStat]
    }
    
    private func crateAdditionalArray(coinDetails: CoinDetail?, coin: CoinModel) -> [Statistic] {
        //Additional
        let high = coin.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = Statistic(title: "24h High", value: high)
        
        let low = coin.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = Statistic(title: "24h Low", value: low)
        
        let priceChange = coin.priceChangePercentage24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricechangePercent2 = coin.priceChangePercentage24H
        let priceChangeStat = Statistic(title: "24h Price change" , value: priceChange, percentageChange: pricechangePercent2)
        
        let marketCapChange = "$" + (coin.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange2 = coin.marketCapChangePercentage24H
        let marketCapChangeStat = Statistic(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange2)
        
        let blockTime = coinDetails?.blockTimeInMinutes ?? 0
        let blockTimeString = (blockTime == 0) ? "n/a" : "\(blockTime)"
        let blockStat = Statistic(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetails?.hashingAlgorithm ?? "n/a"
        let hashingStat = Statistic(title: "Hashing Algorithm", value: hashing)
        
        return [highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat]
    }
}
