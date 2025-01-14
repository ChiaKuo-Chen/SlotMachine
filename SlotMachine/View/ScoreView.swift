//
//  ScoreView.swift
//  SlotMachine
//
//  Created by 陳嘉國 
//

import SwiftUI

struct ScoreView: View {
    
    // MARK: - PROPERTIES
    var coinValue : Int
    var bet :  Int
    var previousBet : Int

    // MARK: - BODY

    var body: some View {
        HStack {
            Spacer()

            VStack {
                Text("CREDITS")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                NumbersView(number: coinValue, digits: 5)
            }

            Spacer()

            VStack {
                Text("BET")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                NumbersView(number: (bet==0 ? previousBet : bet), digits: 1)
            }
            
            Spacer()
        }

    }
}

#Preview {
    ScoreView(coinValue: 100, bet: 3,  previousBet: 1)
        .background(Color.blue)
}
