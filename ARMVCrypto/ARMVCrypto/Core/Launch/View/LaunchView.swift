//
//  LaunchScreenPreview.swift
//  ARMVCrypto
//
//  Created by Abhishek on 22/11/24.
//

import SwiftUI

struct LaunchView: View {
    @State private var loadingText: [String] = "Loading your portolio...".map{String($0)}
    @State private var showLoadingText = false
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showlaunchView: Bool
    
    var body: some View {
        ZStack {
            Color.launchBackground
                
            VStack {
                Image("logo-transparent")
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            ZStack {
                if showLoadingText {
                    
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(.launchAccent)
                                .offset(y: counter == index ? -7 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 70)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer) { _ in
            
            withAnimation {
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    
                    if loops >= 2 {
                        showlaunchView = false
                    }
                } else {
                    counter += 1
                }
                
            }
        }
    }
}

struct LaunchScreenPreview_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showlaunchView: .constant(true))
    }
}
