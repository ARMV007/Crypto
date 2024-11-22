//
//  SettingsView.swift
//  ARMVCrypto
//
//  Created by Abhishek on 05/11/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationView {
            ZStack {
                Color.cryptoBackground
                    .ignoresSafeArea()
                
                List {
                    aboutSection
                        .listRowBackground(Color.clear)
                    coingeckoSection
                        .listRowBackground(Color.clear)
                    applicationSection
                        .listRowBackground(Color.clear)
                }
                .font(.headline)
                .listStyle(GroupedListStyle())
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.headline)
                    }
                    .tint(.cryptoAccent)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}


extension SettingsView {
    private var coingeckoSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 10) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                
                Text("The crypto currency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
            }
            .font(.callout)
            .fontWeight(.medium)
            .padding(.vertical)
            Link("Visit Coingecko 🥳", destination: URL(string: "https://www.coingecko.com")!)
        } header: {
            Text("CoinGecko")
        }
    }
    
    private var aboutSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 10) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                Text("Crypto is a SwiftUI application that provides real-time cryptocurrency data fetched from the CoinGecko API. The app is architected using the MVVM design pattern, employs Core Data for local storage, and leverages Combine for reactive programming.")
            }
            .font(.callout)
            .fontWeight(.medium)
            .padding(.vertical)
            
            Link("👨🏻‍💻 ARMV007", destination: URL(string: "https://github.com/ARMV007")!)
            Link("🔗 Github", destination: URL(string: "https://github.com/ARMV007/Crypto")!)
        }
    }
    
    private var applicationSection: some View {
        Section {
            Link("Terms of Service", destination: URL(string: "https://github.com/ARMV007/Crypto/blob/main/README.md")!)
            Link("Privacy Policy", destination: URL(string: "https://github.com/ARMV007/Crypto/blob/main/README.md")!)
            Link("Company Website", destination: URL(string: "https://github.com/ARMV007/Crypto/blob/main/README.md")!)
            Link("Learn More", destination: URL(string: "https://github.com/ARMV007/Crypto/blob/main/README.md")!)
        } header: {
            Text("Application")
        }
    }
}
