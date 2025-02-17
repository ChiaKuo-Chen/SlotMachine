//
//  ButtonModifier.swift
//  SlotMachine
//
//  Created by 陳嘉國
//

import SwiftUI

struct ButtonModifier: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.black)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .shadow(color: Color.black, radius: 2, x: 0, y: 0)
            .offset(y: configuration.isPressed ? 5 : .zero)
            .background{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.white)
                    .offset(y: configuration.isPressed ? 5 : .zero)
                    .shadow(color: .gray, radius: 0, x: configuration.isPressed ? .zero : -5, y: configuration.isPressed ? .zero : 5)
                    .shadow(color: .gray, radius: 0, x: configuration.isPressed ? .zero : 5, y: configuration.isPressed ? .zero : 5)
            }
    }
    
}

