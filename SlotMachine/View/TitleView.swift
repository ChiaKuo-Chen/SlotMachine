//
//  TitleView.swift
//  SlotMachine
//
//  Created by 陳嘉國
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        
        Text("BIG WINNER")
            .scaledToFit()
            .font(Font.custom("DFPMingSUBold-B5", size: 60))
            .foregroundStyle(Color.black)
            .shadow(color: Color.white, radius: 4, x: 0, y: 0)
            .shadow(color: Color.white, radius: 3, x: 0, y: 0)
            .shadow(color: Color.white, radius: 2, x: 0, y: 0)
            .shadow(color: Color.white, radius: 1, x: 0, y: 0)
        
    }
}

#Preview {
    TitleView()
        .background(Color.red)
}
