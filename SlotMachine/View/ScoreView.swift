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

        VStack(spacing: 5) {
            HStack {
                Spacer()
                VStack {
                    Text("CREDITS")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    NumberStepView(number: coinValue, digits: 5)
                } // VSTACK
                Spacer()
                VStack {
                    Text("BET")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    NumberStepView(number: (bet==0 ? previousBet : bet), digits: 1)
                } // VSTACK
                Spacer()
            } // HSTACK
        } // VSTACK

    }
}

#Preview {
    ScoreView(coinValue: 100, bet: 3,  previousBet: 1)
        .background(Color.blue)
}
