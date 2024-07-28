//
//  CustomSegmentedControl.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 23/07/24.
//

import SwiftUI
struct CustomSegmentedControl: View {
    @Binding var selectedIndex: Int
    @Binding var currentScreenModels: [BaseDataModel]
    @Namespace private var namespace
    @State private var localSelectedIndex = 0
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                HStack(spacing: .p20) {
                    ForEach(currentScreenModels.indices, id:\.self) { index in
                        ZStack {
                            if index == selectedIndex {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.red.opacity(0.5))
                                    .offset(y: .p32)
                                    .matchedGeometryEffect(id: "ID", in: namespace)
                                
                            }
                            Text(currentScreenModels[index].tabTitle)
                                .font(.setFont(localSelectedIndex == index ? .bold700 : .medium500, .p16))
                                .foregroundStyle(Color.black)
                                .padding(.p2)
                        }
                        .id(index)
                        .padding(.bottom, .p10)
                        .frame(maxWidth: .infinity)
                        .frame(height: .p28)
                        .onTapGesture {
                            withAnimation {
                                selectedIndex = index
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: .p16, leading: .p16, bottom: .p4, trailing: .p16))
                .onChange(of: selectedIndex) {
                    withAnimation {
                        proxy.scrollTo(selectedIndex, anchor: .top)
                    }
                }
            }
        }
        .onAppear {
            localSelectedIndex = selectedIndex
        }
        .onChange(of: selectedIndex) { _, newValue in
            localSelectedIndex = newValue
        }
    }
}
#Preview {
    HomeScreen()
}
