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

//struct ButtonStyle: ButtonStyle {
//
//    func makeBody(configuration: Self.Configuration) -> some View {
//        configuration.label
//            .font(.title)
//            .fontWeight(.bold)
//            .foregroundStyle(.black)
//            .padding(.horizontal, 10)
//            .padding(.vertical, 10)
//            .background{
//
//                RoundedRectangle(cornerRadius: 20)
//                    .foregroundStyle(.white)
//                    .shadow(color: .gray, radius: 0, x: -5, y: 5)
//                    .shadow(color: .gray, radius: 0, x: 5, y: 5)
//            }
//    }
//}
