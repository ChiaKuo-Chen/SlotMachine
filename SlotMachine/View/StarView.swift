//
//  StarView.swift
//  SlotMachine
//
//  Created by 陳嘉國 on 2024/12/25.
//

import SwiftUI

struct StarView: View {
    
    // MARK: - PROPERTIES

    @State var switchState : Bool = false
    
    // MARK: - BODY

    var body: some View {
        HStack {
            Image(switchState ? "starWhite" : "starRed")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Image(switchState ? "starRed" : "starWhite")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Image(switchState ? "starWhite" : "starRed")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Image(switchState ? "starRed" : "starWhite")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Image(switchState ? "starWhite" : "starRed")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Image(switchState ? "starRed" : "starWhite")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Image(switchState ? "starWhite" : "starRed")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Image(switchState ? "starRed" : "starWhite")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)

        } // HSTACK
        .onAppear{
            switchState = true
            
            _ = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { timer in
                switchState.toggle()
            }

        }


    }
}

#Preview {
    StarView()
}
