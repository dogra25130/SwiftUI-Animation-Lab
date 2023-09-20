//
//  StaggeredGrid.swift
//  ScrollViewRefreshable
//
//  Created by Abhishek Dogra on 20/09/23.
//

import SwiftUI

struct StaggeredGrid<Content:View, T: Identifiable>: View where T: Hashable {
    var list: [T]
    var content: (T) -> Content
    var showIndicators: Bool
    var spacing: CGFloat
    var columns: Int
    init(columns: Int, showIndicators: Bool = false, spacing: CGFloat = 10, list: [T],@ViewBuilder content: @escaping (T) -> Content) {
        self.list = list
        self.content = content
        self.showIndicators = showIndicators
        self.spacing = spacing
        self.columns = columns
    }
    
    func setupList() -> [[T]] {
        var gridArray: [[T]] = Array(repeating: [], count: columns)
        var currentIndex = 0
        for object in list {
            gridArray[currentIndex].append(object)
            currentIndex = (currentIndex + 1) % columns
        }
        return gridArray
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: showIndicators) {
            
            HStack(alignment: .top) {
                ForEach(setupList(), id: \.self) { columnData in
                    LazyVStack(spacing: spacing) {
                        ForEach(columnData) { object in
                            content(object)
                        }
                    }
                }
            }
            .padding(.vertical)
        }
    }
}

struct StaggeredGrid_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
