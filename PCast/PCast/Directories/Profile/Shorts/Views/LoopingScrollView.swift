//
//  InfiniteCarouselView.swift
//  PCast
//
//  Created by Abhishek Dogra on 21/09/24.
//

import SwiftUI

struct LoopingScrollView<Content: View, Item: RandomAccessCollection>: View where Item.Element: Identifiable {
    var height: CGFloat
    var spacing: CGFloat = 0
    var items: Item
    @Binding var offset: CGFloat
    var content: (Item.Element) -> Content
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let repeatingCount = height > 0 ? Int((size.height / height).rounded()) : 1
            ScrollView(.vertical) {
                if items.count > 0 {
                    VStack(spacing: .zero) {
                        ForEach(items) { item in
                            content(item)
                                .frame(height: height)
                        }
                        ForEach(0..<repeatingCount, id: \.self) { index in
                            let item = Array(items)[index % items.count]
                            content(item)
                                .frame(height: height)
                            
                        }
                    }
                    .background(
                        ScrollViewHelper(height: height,
                                         spacing: spacing,
                                         itemsCount: items.count,
                                         repeatingCount: repeatingCount,
                                         offset: $offset)
                    )
                }
            }
            .scrollTargetBehavior(.paging)
            .scrollIndicators(.hidden)
            
        }
    }
}

struct ScrollViewHelper: UIViewRepresentable {
    var height: CGFloat
    var spacing: CGFloat
    var itemsCount: Int
    var repeatingCount: Int
    @Binding var offset: CGFloat
    func makeUIView(context: Context) -> some UIView {
        return .init()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(height: height, spacing: spacing, itemsCount: itemsCount, repeatingCount: repeatingCount) { value in
            offset = value
        }
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        context.coordinator.height = height
        context.coordinator.spacing = spacing
        context.coordinator.itemsCount = itemsCount
        context.coordinator.repeatingCount = repeatingCount
        DispatchQueue.main.async {
            if let scrollView = uiView.superview?.superview?.superview as? UIScrollView,
               !context.coordinator.isAdded {
                scrollView.delegate = context.coordinator
                context.coordinator.isAdded = true
            }
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var height: CGFloat
        var spacing: CGFloat
        var itemsCount: Int
        var repeatingCount: Int
        var currentOffset: (CGFloat) -> ()
        
        var isAdded: Bool = false
        init(height: CGFloat, spacing: CGFloat, itemsCount: Int, repeatingCount: Int,
             currentOffset: @escaping (CGFloat) -> ()) {
            self.height = height
            self.spacing = spacing
            self.itemsCount = itemsCount
            self.repeatingCount = repeatingCount
            self.currentOffset = currentOffset
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            guard itemsCount > 0 else { return }
            let minY = scrollView.contentOffset.y
            let mainContentSize = CGFloat(itemsCount) * height
            let spacingSize = CGFloat(itemsCount) * spacing
            
            if minY > (mainContentSize + spacingSize) {
                scrollView.contentOffset.y -= (mainContentSize + spacingSize)
            }
            if minY < 0 {
                scrollView.contentOffset.y += (mainContentSize + spacingSize)
            }
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let mainContentSize = CGFloat(itemsCount) * height
            currentOffset(scrollView.contentOffset.y / mainContentSize)
        }
    }
    
}
