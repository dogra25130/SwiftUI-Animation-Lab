//
//  ContentView.swift
//  Parallax Card
//
//  Created by Abhishek Dogra on 02/07/23.
//

import SwiftUI

struct ContentView: View {
    @State var offset: CGSize = .zero
    var body: some View {
        GeometryReader {
            let size = $0.size
            let imageSize = size.width * 0.7
            VStack {
                Image("image1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageSize)
                    .rotationEffect(.init(degrees: -20))
                    .zIndex(1)
                    .offset(x: 10)
                    .offset(x: offset2Angle().degrees * 5, y: offset2Angle(true).degrees * 5)
                
                Text("turtles".uppercased())
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .padding(.top, -60)
                    .padding(.bottom, 50)
                    .zIndex(0)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("turtles".uppercased())
                        .font(.callout)
                        .fontWeight(.semibold)
                        .fontWidth(.compressed)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundColor(.white)
            .padding(.top, 65)
            .frame(width: imageSize)
            .background(content: {
                ZStack {
                    Rectangle()
                        .fill()
                        .foregroundColor(Color(red: 0, green: 0.11, blue: 0.188))
                        .frame(height: 400)
                        
                    Circle()
                        .fill()
                        .scaleEffect(1.2, anchor: .leading)
                        .foregroundColor(Color(red: 0.09, green: 0.42, blue: 0.529))
                        .frame(width: imageSize)
                        .offset(x: imageSize * 0.3, y: -imageSize * 0.5)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            })
            .rotation3DEffect(offset2Angle(true), axis: (x: -1, y: 0, z: 0))
            .rotation3DEffect(offset2Angle(), axis: (x: 0, y: 1, z: 0))
            .scaleEffect(1.2)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        offset = value.translation
                    }).onEnded({ _ in
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.32, blendDuration: 0.32)) {
                            offset = .zero
                        }
                    })
            )
        }
    }
    
    func offset2Angle(_ isVertical: Bool = false) -> Angle {
        let progress = (isVertical ? offset.height : offset.width) / (isVertical ? screenSize.height : screenSize.width)
        return .init(degrees: progress * 10)
    }
    
    var screenSize: CGSize = {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return window.screen.bounds.size
    }()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
