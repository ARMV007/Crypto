//
//  HomeStatView.swift
//  ARMVCrypto
//
//  Created by Abhishek on 01/11/24.
//

import SwiftUI

struct HomeStatView: View {
    @EnvironmentObject private var viewModel : HomeViewModel
    
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(viewModel.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatView(showPortfolio: .constant(false))
        .environmentObject(DeveloperPreview.instance.homeVM)
}
