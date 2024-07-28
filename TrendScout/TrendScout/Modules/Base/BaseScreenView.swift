//
//  BaseScreenView2.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 28/07/24.
//

import SwiftUI

struct BaseScreenView: View {
    @StateObject var viewModel = BaseScreenViewModel()
    @Binding var sideTab: MenuOptions
    @Binding var showSideMenu: Bool
    @State private var selectedTab: Int = 0
    @State private var screenWidth = 0.0
    @Namespace private  var namespace
    var body: some View {
        MaterialTabs(
            isHeaderStrechy: false,
            selectedTab: $selectedTab,
            headerTitle: { context in
                TopInfoBar()
                    .padding(.top, Utils.getSafeAreaTop())
            },
            headerTabBar: { context in
                MaterialTabBar(selectedTab: $selectedTab, sizing: .equalWidth, context: context)
            },
            headerBackground: { context in
                Utils.textTheme
            },
            content: {
                ForEach(0..<viewModel.baseModel.count, id: \.self) { index in
                    MaterialTabsScroll(tab: index) { _ in
                        VerticalContent(for: viewModel.baseModel[index])
                            .padding(.top)
                    }
                    .materialTabItem(
                        tab: index,
                        label: { tab, context, tapped in
                            ZStack {
                                if tab == context.selectedTab {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.red.opacity(0.5))
                                        .offset(y: .p28)
                                        .matchedGeometryEffect(id: "ID", in: namespace)
  
                                    
                                }
                                Text(viewModel.baseModel[safe: index]?.tabTitle ?? "")
                                    .font(.setFont(tab == context.selectedTab ? .bold700 : .medium500, .p16))
                                    .foregroundStyle(Color.black)
                                    .padding(.horizontal, .p6)
                                    .padding(.p2)
                            }
                            .id(index)
                            .padding(.bottom, .p6)
                            .frame(maxWidth: .infinity)
                            .onTapGesture(perform: tapped)
                            .padding(.top, Utils.getSafeAreaTop())
                        }
                    )
                }
            }
        )
        .onAppear {
            viewModel.fetchData(for: sideTab)
        }
        .onChange(of: sideTab) {
            viewModel.fetchData(for: sideTab)
        }
    }
}

extension BaseScreenView {
    
    
    @ViewBuilder
    private func VerticalContent(for model: BaseDataModel) -> some View {
        VStack(alignment: .leading) {
            GeometryReader { proxy in
                HStack {
                    Text("Trending for \(model.tabTitle)")
                        .font(.setFont(.semiBold600, .p28))
                        .foregroundStyle(Utils.textTheme)
                    
                    Spacer()
                }
                .frame(height: proxy.size.height)
                .frame(maxWidth: .infinity)
                .onAppear {
                    screenWidth = proxy.size.width / 2 - .p24
                }
            }
            .padding(.top)
            
            HStack(alignment: .top, spacing: .p12) {
                LazyVStack(spacing: 8) {
                    ForEach(model.splitArray.first ?? []) { detail in
                        ProductCardViewV1(data: detail,
                                          width: screenWidth,
                                          height: screenWidth * detail.aspectRatio)
                    }
                }
                LazyVStack(spacing: 8) {
                    ForEach(model.splitArray.last ?? []) { detail in
                        ProductCardViewV1(data: detail,
                                          width: screenWidth,
                                          height: screenWidth * detail.aspectRatio)
                    }
                }
            }
            .padding(.top, .p24)
        }
        .padding(.horizontal)
    }
}

#Preview {
    HomeScreen()
}

extension BaseScreenView {
    @ViewBuilder
    func TopInfoBar() -> some View {
        VStack(spacing: .p32) {
            HStack(alignment: .center, spacing: .p16) {
                OptionsView()
                Spacer()
                AddressView()
                Spacer()
                SearchView()
            }
            
            RoundedRectangle(cornerRadius: .p24)
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .foregroundStyle(RadialGradient(colors: [Utils.themePrimaryGradientColor2,
                                                         Utils.themePrimaryGradientColor1],
                                                center: .center, startRadius: .zero, endRadius: 200))
                                 
                .overlay {
                    HStack(spacing: .zero) {
                        VStack(alignment: .leading, spacing: .p8) {
                            Text("Latest \ngadgets")
                                .font(.setFont(.medium500, .p20))
                                .foregroundStyle(Utils.textTheme)
                            HStack(spacing: .p2) {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .foregroundStyle(Color.yellow)
                                    .frame(width: .p10, height: .p10)
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .foregroundStyle(Color.yellow)
                                    .frame(width: .p10, height: .p10)
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .foregroundStyle(Color.yellow)
                                    .frame(width: .p10, height: .p10)
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .foregroundStyle(Color.yellow)
                                    .frame(width: .p10, height: .p10)
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .foregroundStyle(Color.yellow)
                                    .frame(width: .p10, height: .p10)
                            }
                            Spacer()
                            Text("Shop")
                                .padding(.p6)
                                .foregroundStyle(Utils.textTheme)
                                .background(
                                    RoundedRectangle(cornerRadius: .p10)
                                        .stroke(Utils.textTheme)
                                )
                                .bold()
                        }
                        
                        .padding(.vertical)
                        Spacer()
                        Image("Banner1")
                            .resizable()
                            .frame(width: 200, height: 125)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: .p24))
                    }
                    .padding()
                }
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    @ViewBuilder
    private func OptionsView() -> some View {
        Button {
            showSideMenu.toggle()
        } label: {
            Image(systemName: showSideMenu ?
                  "xmark" : "line.3.horizontal")
            .resizable()
            .frame(width: .p16, height: .p16)
            .foregroundStyle(.black)
        }
    }
    
    @ViewBuilder
    private func AddressView() -> some View {
        VStack {
            Text("Home ")
                .font(.setFont(.bold700, .p24))
                .bold()
            
            Text("D-61, Block G, Sector 63")
        }
        .foregroundStyle(.black)
        .lineLimit(1)
    }
    
    @ViewBuilder
    private func SearchView() -> some View {
        Button {
            
        } label: {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: .p24, height: .p24)
                .foregroundStyle(.black)
        }
    }
}
