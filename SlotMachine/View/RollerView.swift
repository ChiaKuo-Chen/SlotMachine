//
//  RollerView.swift
//  SlotMachine
//
//  Created by 陳嘉國
//

import SwiftUI

struct RollerView: View {
    
    // MARK: - PROPERTIES
    var font : Font = .largeTitle
    var weight : Font.Weight = .black
    @State var value : Int = 000
    @State var animationRange : [Int] = []
    
    // MARK: - BODY
    var body: some View {
        
        HStack(spacing: 0) {
            ForEach(0..<animationRange.count, id: \.self) { index in
                
                Text("8")
                    .font(font)
                    .fontWeight(weight)
                    .opacity(0)
                    .overlay{
                        GeometryReader { proxy in
                            let size = proxy.size
                            
                            VStack(spacing: 0) {
                                ForEach(0...9, id: \.self) { number in
                                    Text("\(9-number)")
                                        .font(font)
                                        .fontWeight(weight)
                                        .frame(width: size.width, height: size.height, alignment: .center)
                                }
                            } // VTSACK
                            .offset(y: CGFloat(animationRange[index]-9) * size.height)
                        } // GeometryReader
                        .clipped()
                    }
            }
        } // HTSACK
        .onAppear{
            animationRange = Array(repeating: 0, count: String(format: "%03d", value).count)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                updateText()
            }
            
        }
        
        Button(action: {
            value = Int.random(in: 0...999)
            print(value)
            updateText()
        }, label: {
            Text("ROLL IT")
        })
    }
    
    func updateText(){
        
        let stringValue = String(format: "%03d", value)
        for (index, value) in zip(0..<stringValue.count, stringValue) {
            withAnimation(.interactiveSpring(duration: 3)){
                animationRange[index] = (String(value) as NSString).integerValue
            }
        }
    }
}

#Preview {
    RollerView()
}
