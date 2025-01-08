//
//  ContentView.swift
//  SlotMachine
//
//  Created by 陳嘉國
//

import SwiftUI



struct ContentView: View {
    
    // MARK: - PROPERTIES
    @State var list = ["seven", "cherry", "lemon", "orange", "cherry"]
    @State var rowIndex: Int = 8

    @State var ButtonNotRun = false
    
    // MARK: - BODY
    
    var body: some View {
        
        EmptyView()
        
    }
}

#Preview {
    ContentView()
}

