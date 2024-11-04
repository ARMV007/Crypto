//
//  DetailView.swift
//  ARMVCrypto
//
//  Created by Abhishek on 04/11/24.
//

import SwiftUI

struct DetailView: View {
    let coin: CoinModel
    init(coin: CoinModel) {
        self.coin = coin
        print("init called for \(coin.name)")
    }
    
    var body: some View {
        Text(coin.name)
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
}
