//
//  MarketDataService.swift
//  ARMVCrypto
//
//  Created by Abhishek on 01/11/24.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketData? = nil
    var marketDataSubscriptions: AnyCancellable?
    
    init() {
        getMarketData()
    }
    
    private func getMarketData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscriptions = NetworkManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: {[weak self] (recivedGlobalData) in
                self?.marketData = recivedGlobalData.data
                self?.marketDataSubscriptions?.cancel()
            })
    }
}
