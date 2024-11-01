//
//  StatisticView.swift
//  ARMVCrypto
//
//  Created by Abhishek on 01/11/24.
//

import SwiftUI

struct StatisticView: View {
    let stat: Statistic
    var body: some View {
        VStack {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(.cryptoSecondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(.cryptoAccent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180)
                    )
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle((stat.percentageChange ?? 0) >= 0 ? .cryptoGreen : .cryptoRed)
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)

        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    
    StatisticView(stat: DeveloperPreview.instance.stat1)
    StatisticView(stat: DeveloperPreview.instance.stat2)
    StatisticView(stat: DeveloperPreview.instance.stat3)
}
