//
//  ButtonView.swift
//  SlotMachine
//
//  Created by 陳嘉國
//

import SwiftUI

struct ButtonView: View {
    
    // MARK: - PROPERTIES
    @Binding var playButtonPressed : Bool
    @Binding var coinValue : Int
    @Binding var bet : Int
    @Binding var previousBet : Int
    @Binding var maskOn : Bool

    // MARK: - BODY
    var body: some View {
        
        
        HStack() {
            Spacer()
            betOneButton
            Spacer()
            betMaxButton
            Spacer()
            playButton
            Spacer()
        }
    }
    
    var betOneButton : some View {
        Button(action: {
            if playButtonPressed == false {
                Task {
                    try await coinInsert(1)
                }
            }
        }, label: {
            Text("BET\nONE")
                .modifier(ButtonModifier())
        }) // Button
    } // BetOne VIEW
    
    var betMaxButton : some View {
        Button(action: {
            if playButtonPressed == false {
                let count = 3 - bet
                Task {
                    maskOn = true
                    try await coinInsert(count)
                    try await Task.sleep(for: .seconds(0.3))
                    maskOn = false
                    spinTheWheel(bet)
                }
            }
        }, label: {
            Text("BET\nMAX")
                .modifier(ButtonModifier())
        }) // BUTTON
    } // BetThree VIEW
    
    var playButton : some View {
        
        Button(action: {
            if playButtonPressed == false {
                if bet == 0 {
                    let count = ( previousBet != 0 ? previousBet : 3 )
                    Task {
                        maskOn = true
                        try await coinInsert(count)
                        try await Task.sleep(for: .seconds(0.3))
                        maskOn = false
                        spinTheWheel(bet)
                    }
                } else {
                    spinTheWheel(bet)
                }
            }
        }, label: {
            Text("SPIN\nREELS")
                .modifier(ButtonModifier())
        })
        
    } // PLAY BUTTON
    
    func coinInsert( _ coin : Int) async throws {
        for _ in 0..<coin {
            if bet < 3 && coinValue >= 1 {
                playSound(sound: "dong4", type: "mp3")
                bet += 1
                coinValue -= 1
                previousBet = bet
                try await Task.sleep(for: .seconds(0.3))
            }
        }
    } // BET += in
    
    func spinTheWheel(_ bet: Int) {
        playButtonPressed.toggle()
        previousBet = bet
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6){
            playButtonPressed.toggle()
        }
    } // SPIN THET WHEEL
    
}




#Preview {
    struct Preview: View {
        @State var playButtonPressed : Bool = false
        @State var coinValue : Int = 100
        @State var bet : Int = 1
        @State var previousBet : Int = 1
        @State var maskOn : Bool = false

        var body: some View {
            ZStack {
                Color.blue
                ButtonView(playButtonPressed: $playButtonPressed, coinValue: $coinValue, bet: $bet, previousBet: $previousBet, maskOn: $maskOn)
            }
        }
    }
    
    return Preview()
}
