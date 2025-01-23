//
//  ContentView.swift
//  SlotMachine
//
//  Created by 陳嘉國
//

import SwiftUI



struct ContentView: View {
    
    // MARK: - PROPERTIES
    @State private var rollerImageIndex : [Int] = [4, 4, 5]
    @State private var coinValue : Int = 100
    @State private var playButtonPressed : Bool = false
    @State private var bet : Int = 0
    @State var previousBet : Int = 0
    @State var maskOn : Bool = false
    
    // MARK: - BODY
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 0) {
                Image("background3")
                    .resizable()
                Image("background3")
                    .resizable()
            }
            .ignoresSafeArea()
//            .scaledToFill()
            
            VStack(spacing: 10) {
                
                RollerImageView(rollerImageIndex: $rollerImageIndex, coinValue: $coinValue, bet: $bet, maskOn: $maskOn, buttonPressed: playButtonPressed)
                    .scaleEffect(0.9)

                ScoreView(coinValue: coinValue, bet: bet, previousBet: previousBet)
                    .padding()
                
                ButtonView(playButtonPressed: $playButtonPressed, coinValue: $coinValue, bet: $bet, previousBet: $previousBet, maskOn: $maskOn)
                
                
            }
            
            if maskOn {
                Color.black
                    .opacity(0.001)
            }
            
        } // ZSTACK
        
    }
}

#Preview {
    ContentView()
}

