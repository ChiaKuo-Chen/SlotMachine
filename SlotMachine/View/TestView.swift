//
//  TestView.swift
//  SlotMachine
//
//  Created by 陳嘉國
//

import SwiftUI

struct TestView: View {
    
    // MARK: - PROPERTIES
    @State var value : Int = 200
    @State var goal : Int = 0

    // MARK: - BODY

    var body: some View {
        NumbersView(number: value, digits: 4)
            .onChange(of: goal){
                if value < goal {
                    
                    let stepDuration : TimeInterval = 0.1
                    let totalDuration = goal - value
                    
                    Timer.scheduledTimer(withTimeInterval: stepDuration, repeats: true){ timer in
                        if value != goal {
                            value += 1
                        } else {
                            timer.invalidate()
                        }
                    }

                }
            }
            .onAppear{
                goal = 400
            }
    }
}

#Preview {
    TestView()
}
