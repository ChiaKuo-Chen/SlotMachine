//
//  ButtonModifier.swift
//  SlotMachine
//
//  Created by 陳嘉國
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.black)
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .background{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.white)
                    .shadow(color: .gray, radius: 0, x: -5, y: 5)
                    .shadow(color: .gray, radius: 0, x: 5, y: 5)
            }

    }
}
