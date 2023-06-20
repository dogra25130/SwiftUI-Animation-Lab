//
//  SwiftUIView.swift
//  Tabbar
//
//  Created by Abhishek Dogra on 20/06/23.
//

import SwiftUI

struct TabBar: View {
    @Binding var currentTab: Tab
    @State var yOffset: CGFloat = -25
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button {
                        withAnimation(.easeOut(duration: 0.2)) {
                            currentTab = tab
                            yOffset = -60
                        }
                        withAnimation(.easeOut(duration: 0.1).delay(0.07)){
                            yOffset = -25
                        }
                    } label: {
                        Image(systemName: getImage(value: tab))
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25,height: 25)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? .purple : .gray)
                            .scaleEffect(currentTab == tab ? 1.5 : 1)
                            .shadow(color: currentTab == tab ? .purple : .white, radius: 20)

                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(alignment: .leading) {
                Circle()
                    .frame(width: 15, height: 15)
                    .offset(x: 15 + indicatorOffset(width: width), y: yOffset)
            }
            
        }
        .frame(height: 30)
        .padding([.horizontal,.top])
        .shadow(color: .purple, radius: 20)
        
    }
    func indicatorOffset(width:CGFloat) -> CGFloat{
        let index = CGFloat(getIndex())
        if index == 0 {
            return 0
        }
        let buttonWidth = width / CGFloat(Tab.allCases.count)
        return index * buttonWidth
    }
    
    func getIndex() -> Int{
        switch currentTab {
        case .home:
            return 0
        case .todo:
            return 1
        case .location:
            return 2
        case .map:
            return 3
        }
    }
    
    func getImage(value: Tab) -> String{
        switch value {
        case .map:
            return "safari.fill"
        case .home:
            return "house.fill"
        case .location:
            return "location.circle.fill"
        case .todo:
            return "list.clipboard.fill"
        }
    }
}
