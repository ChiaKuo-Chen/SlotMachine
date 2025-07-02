//
//  ContentView.swift
//  SlotMachine
//
//  Created by 陳嘉國
//

import SwiftUI



struct ContentView: View {
    
    // MARK: - PROPERTIES
    @StateObject var audioManager = AudioManager()
    
    @State private var rollerImageIndex : [Int] = [4, 4, 5]
    @State private var coinValue : Int = 100
    @State private var playButtonPressed : Bool = false
    @State private var bet : Int = 0
    @State var previousBet : Int = 0
    @State var isRolling : Bool = false
    
    // MARK: - BODY
    
    var body: some View {
        
        ZStack {
            
            Image("background3")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                
                VStack(spacing: 20) {
                    HStack {
                        Spacer()
                        Image(systemName: audioManager.isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 40)
                            .offset(y: 12)
                            .onTapGesture {
                                audioManager.toggleMute()
                            }
                    } // HSTACK
                    
                    TitleView()
                } // VSTACK
                
                Spacer()
                
                RollerImageView(audioManager: audioManager, rollerImageIndex: $rollerImageIndex, coinValue: $coinValue, bet: $bet, isRolling: $isRolling, buttonPressed: playButtonPressed)
                    .scaleEffect(0.9)

                Spacer()

                ScoreView(coinValue: coinValue, bet: bet, previousBet: previousBet)
                
                Spacer()

                ButtonView(audioManager: audioManager, playButtonPressed: $playButtonPressed, coinValue: $coinValue, bet: $bet, previousBet: $previousBet, isRolling: $isRolling)
                
                Spacer()

            } // VSTACK
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        } // ZSTACK
    }
}

#Preview {
    ContentView()
}

