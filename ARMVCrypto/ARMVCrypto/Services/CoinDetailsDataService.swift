//
//  CoinDetailsDataService.swift
//  ARMVCrypto
//
//  Created by Abhishek on 04/11/24.
//

import Foundation
import Combine

class CoinDetailsDataService {
    
    @Published var coinDetail: CoinDetail? = nil

    var coinDetailSubscriptions: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        coinDetailSubscriptions =  NetworkManager.download(url: url)
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self]  (returnedCoinDetail) in
                self?.coinDetail = returnedCoinDetail
                self?.coinDetailSubscriptions?.cancel()
            })
    }
}
