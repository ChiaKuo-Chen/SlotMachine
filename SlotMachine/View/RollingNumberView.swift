//
//  RollingNumberView.swift
//  SlotMachine
//
//  Created by 陳嘉國
//

import SwiftUI

struct RollingNumberView: View {
    
    // MARK: - PROPERTIES
    var number: String
    @State var offset : [CGFloat] = []
    @State var hasAppeared = false
    
    // MARK: - BODY
    
    var body: some View {
        HStack {
            ForEach(0..<number.count, id:\.self) { index in
                let char = Array(number)[index]
                SingleDigitView(char: char, offset: offset[safe: index] ?? 0)
            }
        }
        .onAppear{
            if !hasAppeared {
                setInitialOffset()
                hasAppeared = true
            }
        }
        .onChange(of: number) { oldValue, newValue in
            withAnimation(.easeInOut(duration: 0.5)){
                setOffset()
            }
        }
    }
    func setOffset() {
        withAnimation(.easeInOut(duration: 1)){
            offset = number.map { char -> CGFloat in
                if let digit = Int(String(char)) {
                    return CGFloat(digit) * 78
                } else {
                    return 0
                }
            }
        }
    }
    
    func setInitialOffset() {
        offset = number.map { _ in CGFloat(700) }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            setOffset()
        }
    }

}


#Preview {
    RollingNumberView(number: "321867868")
}

// SINGLE DIGIT VIEW
struct SingleDigitView: View {
    
    var char: Character
    var offset: CGFloat
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                ForEach(0..<10) { number in
                    if char.isNumber {
                        Text("\(number)")
                            .font(Font.system(size: 40))
                            .bold()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    } else {
                        Text("\(char)")
                            .font(Font.system(size: 40))
                            .bold()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
            }
            .offset(y: -offset)
        }
        .frame(width: 25, height: 70)
        .clipped()
    }
}

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
