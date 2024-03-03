//
//  TabBar.swift
//  HorizontalScrollerTabs
//
//  Created by Abhishek Dogra on 25/02/24.
//

import SwiftUI

struct TabBar: View {
    @Binding var offset: CGFloat
    @State var width: CGFloat = 0
    var body: some View {
        GeometryReader { proxy -> AnyView in
            let equalWidth = proxy.frame(in: .global).width / CGFloat(tabs.count)
            DispatchQueue.main.async {
                self.width = equalWidth
            }
            return AnyView(
                ZStack(alignment: .bottomLeading) {
                    Rectangle()
                        .frame(width: equalWidth, height: 1)
                        .offset(x: getOffset())
                    HStack(spacing: 0) {
                        ForEach(tabs.indices, id: \.self) { index in
                            Text(tabs[index])
                                .font(.title)
                                .frame(width: equalWidth)
                                .onTapGesture {
                                    withAnimation {
                                        offset = UIScreen.main.bounds.width * CGFloat(index)
                                    }
                                }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            )
        }
    }
    
    func getOffset() -> CGFloat {
        let progress = offset / UIScreen.main.bounds.width
        return progress * width
    }
}

#Preview {
    ContentView()
}
