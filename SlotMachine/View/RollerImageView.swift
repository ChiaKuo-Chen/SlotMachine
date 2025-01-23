//
//  RollerImageView.swift
//  SlotMachine
//
//  Created by 陳嘉國
//

import SwiftUI

struct RollerImageView: View {
    
    // MARK: - PROPERTIES
    @Binding var rollerImageIndex : [Int]
    @Binding var coinValue : Int
    @Binding var bet : Int
    @Binding var maskOn : Bool
    
    var buttonPressed : Bool
    
    private let imageList : [String] = ["seven", "cherry", "lemon", "cherry"]
    
    private let imageSize : CGFloat = 100
    private let imageHorizontalSpace : CGFloat = 20
    private let imageVerticalSpace : CGFloat = 10
    
    private let frameColorUp : Color = .black
    private let frameColorDown : Color = .black
    private let gradientColor = [Color.black.opacity(1), Color.black.opacity(0)]
    
    // MARK: - BODY
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                .foregroundStyle(Color.gray)
                .frame(width: 380, height: 260)
                .offset(y: 5)

            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(Color.white)
                .frame(width: imageSize*3+imageHorizontalSpace*3, height: imageSize*2+imageVerticalSpace*2)

            HStack(spacing: imageHorizontalSpace) {
                
                ForEach(0..<rollerImageIndex.count, id: \.self) { index in
                    
                    Image("seven")
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageSize, height: imageSize)
                        .opacity(0)
                        .overlay{
                            GeometryReader { proxy in
                                let size = proxy.size
                                
                                VStack(spacing: imageVerticalSpace) {
                                    
                                    ForEach(0...99, id: \.self) { number in
                                        
                                        ZStack {
                                            Rectangle()
                                                .frame(width: size.width, height: size.height, alignment: .center)               .opacity(0.0)
                                            
                                            Image(imageList[ number % imageList.count] )
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: size.width*0.8, height: size.height*0.8, alignment: .center)
                                        }
                                        
                                    } // VTSACK
                                    
                                }
                                .offset(y: -CGFloat(rollerImageIndex[index]) * (size.height+10))
                            } // GeometryReader
                            .clipShape(RollerShape(imageVSpace: imageVerticalSpace))
                            
                        }
                }
            } // HSTACK
            
            rollerShadow
            
            rollerFrame
            
            HollowRoundedRectangleView(color: frameColorUp)
            
        } // ZSTACK
        .onChange(of: buttonPressed){ oldValue, newValue in
            if newValue {
                updateRollerIndex()
                updateCoinValue()
            }
        }
        
    }
    
    
    @ViewBuilder
    var rollerFrame: some View {
        
        LeftCurveShape()
            .stroke(frameColorUp, lineWidth: 8)
            .frame(width: imageHorizontalSpace, height: (imageSize+imageVerticalSpace)*2)
            .offset(x: -(imageSize/2+imageHorizontalSpace)+5)
        
        LeftCurveShape()
            .stroke(frameColorUp, lineWidth: 8)
            .frame(width: imageHorizontalSpace, height: (imageSize+imageVerticalSpace)*2)
            .offset(x: -(imageSize/2+imageHorizontalSpace)+5)
            .rotationEffect(.degrees(180))
    }
    
    @ViewBuilder
    var rollerShadow: some View {
        
        Rectangle()
            .foregroundStyle(.linearGradient(colors: gradientColor, startPoint: .bottom, endPoint: .top))
            .frame(width: imageSize*3+imageHorizontalSpace*3+10, height: imageSize/2+imageVerticalSpace*2)
            .offset(y: imageSize-imageVerticalSpace*1.5)
        
        Rectangle()
            .foregroundStyle(.linearGradient(colors: gradientColor, startPoint: .top, endPoint: .bottom))
            .frame(width: imageSize*3+imageHorizontalSpace*3+10, height: imageSize/2+imageVerticalSpace*2)
            .offset(y: -(imageSize-imageVerticalSpace*1.5))
        
    }
    
    func updateRollerIndex(){
        
        playSound(sound: "reel", type: "mp3", duration: 1.4)
        withAnimation(.interactiveSpring(response: 0.5)){
            rollerImageIndex[0] = Int.random(in: 20..<32)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            playSound2(sound: "ding1", type: "mp3")
        }
        
        withAnimation(.interactiveSpring(response: 1.0)){
            rollerImageIndex[1] = Int.random(in: 40..<64)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            playSound2(sound: "ding2", type: "mp3")
        }
        
        withAnimation(.interactiveSpring(response: 1.4)){
            rollerImageIndex[2] = Int.random(in: 60..<96)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4){
            playSound2(sound: "ding3", type: "mp3")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            rollerImageIndex[0] = rollerImageIndex[0] % imageList.count + imageList.count
            rollerImageIndex[1] = rollerImageIndex[1] % imageList.count + imageList.count
            rollerImageIndex[2] = rollerImageIndex[2] % imageList.count + imageList.count
        }
    }
    
    func updateCoinValue(){
        
        let imageSet = Set(imageList)
        var duration = 1.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4){
            for item in imageSet {
                if checkIsWinOrNot(item) {
                    switch item {
                        
                    case "seven":
                        coinValue += 300*bet
                        duration = 1.5*Double(bet)+0.1
                    case "lemon":
                        coinValue += 10*bet
                    case "cherry":
                        coinValue += 2*bet
                    default: break
                    }
                    
                    playSound(sound: "jackpotCoin", type: "mp3", duration: duration)
                    
                    maskOn = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration){
                        maskOn = false
                    } // Prevent Player Play While The Value is Updating
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            bet = 0
        }
        
        
    }
    
    private func checkIsWinOrNot(_ item: String) -> Bool {
        
        if imageList[rollerImageIndex[0] % imageList.count] == item &&
            imageList[rollerImageIndex[1] % imageList.count] == item &&
            imageList[rollerImageIndex[2] % imageList.count] == item {
            return true
        }
        return false
        
    }
    
}


struct HollowRoundedRectangleView: View {
    
    var color : Color?
    
    var body: some View {
        Path { path in
            
            path.addRoundedRect(in: CGRect(x: 0, y: 0, width: 380, height: 260), cornerSize: CGSize(width: 20, height: 20))
            
            path.addRoundedRect(in: CGRect(x: 10, y: 20, width: 360, height: 220), cornerSize: CGSize(width: 40, height: 80))
            
        }
        .fill(color ?? Color.white, style: FillStyle(eoFill: true))
        .frame(width: 380, height: 260)
        
    }
}

struct LeftCurveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY), control: CGPoint(x: rect.minX, y: rect.midY))
        
        return path
    }
}

struct RollerShape: Shape {
    
    var imageVSpace : CGFloat?
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addLines([
                CGPoint(x: rect.minX, y: -rect.midY-(imageVSpace ?? 0)),
                CGPoint(x: rect.maxX, y: -rect.midY-(imageVSpace ?? 0)),
                CGPoint(x: rect.maxX, y: rect.maxY*1.5+(imageVSpace ?? 0)),
                CGPoint(x: rect.minX, y: rect.maxY*1.5+(imageVSpace ?? 0))
            ])
        }
    }
}


#Preview {
    struct Preview: View {
        
        @State var rollerImageIndex : [Int] = [4, 4, 5]
        @State var coinValue : Int = 300
        @State var bet : Int = 1
        @State var maskOn : Bool = false
        
        var body: some View {
            RollerImageView(rollerImageIndex: $rollerImageIndex, coinValue: $coinValue, bet: $bet, maskOn: $maskOn, buttonPressed: false)
        }
        
    }
    
    return Preview()
}
