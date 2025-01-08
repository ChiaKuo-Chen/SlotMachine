//
//  RollerImageView.swift
//  SlotMachine
//
//  Created by 陳嘉國
//

import SwiftUI

struct RollerImageView: View {
    
    // MARK: - PROPERTIES
    @State var rollerImageIndex : [Int] = [5, 5, 6]
    
    private let imageListFirst = ["seven", "cherry", "orange", "lemon", "cherry", "diamond" , "orange", "orange", "lemon"]
    private let imageListSecond = ["seven", "cherry", "orange", "lemon", "cherry", "diamond" ,  "orange", "lemon", "lemon"]
    private let imageListThird = ["seven", "cherry", "orange", "lemon", "cherry", "diamond" ,  "orange", "cherry", "lemon"]

    private let imageSize : CGFloat = 100
    private let imageHorizontalSpace : CGFloat = 20
    private let imageVerticalSpace : CGFloat = 10

    private let frameColor : Color = .gray
    private let gradientColor = [Color.black.opacity(0.8), Color.black.opacity(0)]

    // MARK: - BODY
    var body: some View {
        
        ZStack {
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.7)

            VStack {
                
                ZStack {
                    
                    
                    RoundedRectangle(cornerSize: CGSize(width: imageVerticalSpace*4, height: 80))
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
                                                    
                                                    Image(imageListFirst[ (99-number) % imageListFirst.count] )
//                                                    switch index {
//                                                    case 0:
//                                                        Image(imageListFirst[ (99-number) % imageListFirst.count] )
//                                                    case 1:
//                                                        Image(imageListSecond[ (99-number) % imageListSecond.count] )
//
//                                                    case 2:
//                                                        Image(imageListThird[ (99-number) % imageListThird.count] )
//
//                                                    default:
//                                                        Image(imageListFirst[ (99-number) % imageListFirst.count] )
//
//                                                    }
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
                        
                    HollowRoundedRectangleView()
                    
                } // ZSTACK
                
                button
                
            } // VSTACK
            
        } // ZSTACK
    }
    
    
    @ViewBuilder
    var rollerFrame: some View {
        
        LeftCurveShape()
            .stroke(frameColor, lineWidth: 5)
            .frame(width: imageHorizontalSpace*2, height: (imageSize+imageVerticalSpace)*2)
            .offset(x: -imageSize*2+imageHorizontalSpace)
        
        LeftCurveShape()
            .stroke(frameColor, lineWidth: 8)
            .frame(width: imageHorizontalSpace, height: (imageSize+imageVerticalSpace)*2)
            .offset(x: -(imageSize/2+imageHorizontalSpace)+5)
        
        LeftCurveShape()
            .stroke(frameColor, lineWidth: 8)
            .frame(width: imageHorizontalSpace, height: (imageSize+imageVerticalSpace)*2)
            .offset(x: -(imageSize/2+imageHorizontalSpace)+5)
            .rotationEffect(.degrees(180))
        
        LeftCurveShape()
            .stroke(frameColor, lineWidth: 5)
            .frame(width: imageHorizontalSpace*2, height: (imageSize+imageVerticalSpace)*2)
            .offset(x: -imageSize*2+imageHorizontalSpace)
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
    
    private var button: some View {
        Button(action: {
            updateRollerImage()
        }, label: {
            Text("會贏喔")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.black)
                }
        })
    }
    
    func updateRollerImage(){
        withAnimation(.interactiveSpring(response: 0.5)){
            rollerImageIndex[0] = Int.random(in: 48...64)
        }
        
        withAnimation(.interactiveSpring(response: 1.0)){
            rollerImageIndex[1] = Int.random(in: 64...80)
        }
        
        withAnimation(.interactiveSpring(response: 1.5)){
            rollerImageIndex[2] = Int.random(in: 80...96)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6){
            rollerImageIndex[0] = rollerImageIndex[0] % 4 + 4
            rollerImageIndex[1] = rollerImageIndex[1] % 4 + 4
            rollerImageIndex[2] = rollerImageIndex[2] % 4 + 4
        }
    }
    
}


struct HollowRoundedRectangleView: View {
    var body: some View {
        Path { path in
            
            path.addRect(CGRect(x: 0, y: 0, width: 370, height: 240))

            path.addRoundedRect(in: CGRect(x: 5, y: 10, width: 360, height: 220), cornerSize: CGSize(width: 40, height: 80))

        }
        .fill(Color.gray, style: FillStyle(eoFill: true))
        .frame(width: 370, height: 240)

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
    RollerImageView()
}
