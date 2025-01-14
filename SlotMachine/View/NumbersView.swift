//
//  NumbersView.swift
//  SlotMachine
//
//  Created by 陳嘉國
//

import SwiftUI

struct NumbersView: View {
    
    // MARK: - PROPERTIES
    //var startNumber : Int
    var number : Int
    var digits : Int

    // MARK: - BODY
    var body: some View {
        
        let numberArray : [Character] = numberToArray(number)
        
        HStack {
            ForEach(numberArray.indices) { index in
                Image("digit\(numberArray[index])")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
            }
            
        } // HSTACK
        .padding()
        .background(
            Rectangle()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 5))
        )
        
    }
    
    func numberToArray(_ number: Int) -> [Character] {
        let string = String(format: "%0\(digits)d", number)
        var returnValue : [Character] = []
        var firstDigitShown = false
        for character in string {
            if firstDigitShown {
                returnValue.append(character)
            } else {
                if character != "0" {
                    firstDigitShown = true
                    returnValue.append(character)
                } else {
                    returnValue.append("X")
                }
            }
        }
        return returnValue
    }
    
}

#Preview {
    ZStack {
        Color.blue
        //startNumber: 200,
        NumbersView(number: 197, digits: 4)
    }
}
