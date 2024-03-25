//
//  ScrollableTabBar.swift
//  HorizontalScrollerTabs
//
//  Created by Abhishek Dogra on 25/02/24.
//

import SwiftUI
struct ScrollableTabBar<Content: View>: UIViewRepresentable {
    
    var content: Content
    let scrollView = UIScrollView()
    var rect: CGRect
    @Binding var offset: CGFloat
    var tabs: [Any]
    
    init(tabs: [Any], rect: CGRect, offset: Binding<CGFloat>, @ViewBuilder content: ()->Content) {
        self.content = content()
        self.rect = rect
        self.tabs = tabs
        _offset = offset
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        setupScrollView()
        scrollView.contentSize = CGSize(width: rect.width * CGFloat(tabs.count), height: rect.height)
        scrollView.addSubview(extractView())
        scrollView.delegate = context.coordinator
        return scrollView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if uiView.contentOffset.x != offset {
            uiView.delegate = nil
            UIView.animate(withDuration: 0.4) {
                uiView.contentOffset.x = offset
                uiView.contentOffset.y = offset
            } completion: { (status) in
                if status {
                    uiView.delegate = context.coordinator
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        ScrollableTabBar.Coordinator(parent: self)
    }
    
    func setupScrollView() {
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    func extractView() -> UIView {
        let controller = UIHostingController(rootView: content)
        controller.view.frame = CGRect(x: 0, y: 0, width: rect.width * CGFloat(tabs.count), height: rect.height)
        return controller.view ?? UIView()
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        let parent: ScrollableTabBar
        
        init(parent: ScrollableTabBar) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
        }
    }
}
