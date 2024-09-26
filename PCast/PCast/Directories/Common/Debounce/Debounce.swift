//
//  Debounce.swift
//  PCast
//
//  Created by Abhishek Dogra on 19/08/24.
//

import Foundation
final class Debounce {
    private let timeInterval: TimeInterval = 0.3
    private var dispatchWorkItem = DispatchWorkItem(block: {})
    
    func dispatch(_ block: @escaping () -> Void) {
        dispatchWorkItem.cancel()
        let workItem = DispatchWorkItem {
            block()
        }
        dispatchWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: dispatchWorkItem)
    }
}
