//
//  SearchBarView.swift
//  ARMVCrypto
//
//  Created by Abhishek on 29/10/24.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? Color.cryptoSecondaryText : Color.cryptoAccent
                )
            TextField("Search by name or symbols.....", text: $searchText)
                .foregroundStyle(.cryptoAccent)
                .disableAutocorrection(true)
                .overlay (
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(.cryptoAccent)
                        .opacity(
                            searchText.isEmpty ? 0.0 : 1.0
                        )
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    , alignment: .trailing
                )
            
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.cryptoBackground)
                .shadow(
                    color: .cryptoAccent.opacity(0.15),
                    radius: 10,
                    x: 0,
                    y: 0
                )
        )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant("")
    )
}
