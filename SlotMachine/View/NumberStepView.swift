//
//  TestView.swift
//  SlotMachine
//
//  Created by 陳嘉國
//

import SwiftUI

struct NumberStepView: View {
    
    // MARK: - PROPERTIES
    var number : Int
    var digits : Int

    // MARK: - BODY
    
    var body: some View {
        StepView(start: number, goal: number, digits: digits)
    }
    
}

struct StepView: View {
    
    // MARK: - PROPERTIES
    @State var start : Int
    var goal : Int
    var digits : Int
    
    // MARK: - BODY
    
    var body: some View {
        
        let numberStep = ( start < goal ? +1 : -1)
        let stepDuration : TimeInterval = ( abs(goal-start)<10 ? 0.2 : 0.001 )
        
        NumbersView(number: start, digits: digits)
            .onChange(of: goal){
                Timer.scheduledTimer(withTimeInterval: stepDuration, repeats: true){ timer in
                    if start != goal {
                        start += numberStep
                    } else {
                        timer.invalidate()
                    }
                }
            }
    }
    
}

#Preview {
    NumberStepView(number: 200, digits: 4)
}
