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
            if bet < 3 {
                bet += 1
                previousBet = bet
                coinValue -= 1
            }
        }, label: {
            Text("BET\nONE")
                .modifier(ButtonModifier())
        }) // Button
    } // BetOne VIEW
    
    var betMaxButton : some View {
        Button(action: {
            if playButtonPressed == false {
                if 3 <= coinValue {
                    bet = 3
                    coinValue -= bet
                } else if coinValue == 2 {
                    bet = 2
                    coinValue -= bet
                } else {
                    bet = 1
                    coinValue -= bet
                }
                spinTheWheel(bet)
            }
        }, label: {
            Text("BET\nMAX")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.black)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.white)
                }

        }) // BUTTON
    } // BetThree VIEW
    
    var playButton : some View {
        
        Button(action: {
            if playButtonPressed == false {
                if bet == 0 {
                    if ( previousBet != 0 ? previousBet : 3 ) <= coinValue {
                        bet = ( previousBet != 0 ? previousBet : 3 )
                        coinValue -= bet
                        spinTheWheel(bet)
                    }
                } else {
                    if bet <= coinValue {
                        spinTheWheel(bet)
                    }
                }
                
            }
        }, label: {
            Text("SPIN\nREELS")
                .modifier(ButtonModifier())
        })
        
    } // PLAY BUTTON
    
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
        
        var body: some View {
            ZStack {
                Color.blue
                ButtonView(playButtonPressed: $playButtonPressed, coinValue: $coinValue, bet: $bet, previousBet: $previousBet)
            }
        }
    }
    
    return Preview()
}
