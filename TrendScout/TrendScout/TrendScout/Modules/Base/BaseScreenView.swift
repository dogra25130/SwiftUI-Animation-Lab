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
    @State private var safeAreaPaddingFactor = 0.0
    @Namespace private  var namespace
    @State private var isPresented = false
    @State private var scrollOffset: CGFloat = .zero
    var body: some View {
        NavigationStack {
            MaterialTabs(
                isHeaderStrechy: false,
                selectedTab: $selectedTab,
                headerTitle: { context in
                    TopInfoBar()
                },
                headerTabBar: { context in
                    MaterialTabBar(selectedTab: $selectedTab, sizing: .equalWidth, context: context)
                        .blur(radius: showSideMenu ? .p10 : .zero)
                },
                headerBackground: { context in
                    Utils.topbarBackgroundTheme
                },
                content: {
                    ContentView
                }
            )
            .onAppear {
                viewModel.fetchData(for: sideTab)
            }
            .onChange(of: sideTab) {
                viewModel.fetchData(for: sideTab)
            }
            .sheet(isPresented: $isPresented) {
                SwipeableCardsView()
            }
            .onChange(of: scrollOffset) { _, val in
                safeAreaPaddingFactor = val
            }
        }
    }
}

extension BaseScreenView {
    func headerTabBar(_ context:  HeaderContext<Int>) -> some View {
        MaterialTabBar(selectedTab: $selectedTab, sizing: .equalWidth, context: context)
    }
}
extension BaseScreenView {
    var ContentView: some View {
        
        ForEach(0..<viewModel.baseModel.count, id: \.self) { index in
            let model = viewModel.baseModel[index]
            MaterialTabsScroll(tab: index, scrollOffset: $scrollOffset) { _ in
                LazyVStack {
                    VerticalContent(for: model, showHeader: true)
                        .padding(.top)
                }
            }
            .materialTabItem(tab: index, label: .primary(model.tabTitle,
                                                         icon: nil,
                                                         config: .init(titleStyle: Utils.textTheme,
                                                                       underlineStyle: Color.red.opacity(0.5),
                                                                       bottomRuleThickness: .zero,
                                                                       padding: EdgeInsets(top: .zero, leading: .p16, bottom: .zero, trailing: .zero)),
                                                         deselectedConfig: nil))
        }
    }
}


extension BaseScreenView {
    @ViewBuilder
    private func VerticalContent(for model: BaseDataModel, showHeader: Bool) -> some View {
        LazyVStack(alignment: .leading) {
            HStack {
                Text("Trending for \(model.tabTitle)")
                    .font(.setFont(.semiBold600, .p28))
                    .foregroundStyle(Utils.textTheme)
                    .opacity(showHeader ? 1.0 : 0.0)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.top)
            
            HStack(alignment: .top, spacing: .p12) {
                LazyVStack(spacing: 8) {
                    ForEach(model.splitArray.first ?? []) { detail in
                        ProductCardViewV1(data: detail,
                                          aspectRatio: detail.aspectRatio)
                    }
                }
                LazyVStack(spacing: 8) {
                    ForEach(model.splitArray.last ?? []) { detail in
                        ProductCardViewV1(data: detail,
                                          aspectRatio: detail.aspectRatio)
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
    
    func TopInfoBar() -> some View {
        VStack(spacing: .p32) {
            HStack(alignment: .center, spacing: .p16) {
                OptionsView()
                Spacer()
                AddressView()
                Spacer()
                SearchView()
            }
            .foregroundStyle(Utils.textTheme)
            RoundedRectangle(cornerRadius: .p24)
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .foregroundStyle(RadialGradient(colors: [Utils.themePrimaryGradientColor2,
                                                         Utils.themePrimaryGradientColor1],
                                                center: .center, startRadius: .zero, endRadius: 200))
                .onTapGesture {
                    isPresented.toggle()
                }
                .overlay {
                    HStack(spacing: .zero) {
                        VStack(alignment: .leading, spacing: .p8) {
                            Text("Latest \ngadgets")
                                .font(.setFont(.medium500, .p20))
                                .foregroundStyle(Utils.textThemeSecondary)
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
                                .foregroundStyle(Utils.textThemeSecondary)
                                .background(
                                    RoundedRectangle(cornerRadius: .p10)
                                        .stroke(Utils.textThemeSecondary)
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
        .offset(y: getTopSpacing())
    }
    
    private func getTopSpacing() -> CGFloat {
        return safeAreaPaddingFactor >= 0 ? 0 : safeAreaPaddingFactor / 3
    }
    
    private func OptionsView() -> some View {
        Button {
            showSideMenu.toggle()
        } label: {
            Image(systemName: showSideMenu ?
                  "xmark" : "line.3.horizontal")
            .resizable()
            .frame(width: .p16, height: .p16)
            .foregroundStyle(Utils.textTheme)
        }
    }
    
    
    private func AddressView() -> some View {
        VStack {
            Text("Home ")
                .font(.setFont(.bold700, .p24))
                .bold()
            
            Text("D-61, Block G, Sector 63")
        }
        .lineLimit(1)
    }
    
    @ViewBuilder
    private func SearchView() -> some View {
        Button {
            
        } label: {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: .p24, height: .p24)
                .foregroundStyle(Utils.textTheme)
        }
    }
}
