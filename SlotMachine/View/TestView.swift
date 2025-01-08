//
//  TestView.swift
//  SlotMachine
//
//  Created by 陳嘉國 on 2025/1/3.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        
        Path { path in
            // 绘制外部长方形
            path.addRect(CGRect(x: 0, y: 0, width: 300, height: 200))
            // 绘制中心的空洞（圆形）
            path.addEllipse(in: CGRect(x: 100, y: 50, width: 100, height: 100))
        }
        .fill(Color.blue, style: FillStyle(eoFill: true)) // 使用even-odd填充规则
        .frame(width: 300, height: 200)

    }
}

#Preview {
    TestView()
}
