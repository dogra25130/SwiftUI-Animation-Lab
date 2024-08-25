//
//  Debounce.swift
//  PCast
//
//  Created by Abhishek Dogra on 19/08/24.
//

import Foundation
final class Debounce {
    private let timeInterval: TimeInterval
    private let queue: DispatchQueue
    private var dispatchWorkItem = DispatchWorkItem(block: {})
    
    init(timeInterval: TimeInterval, queue: DispatchQueue, dispatchWorkItem: DispatchWorkItem = DispatchWorkItem(block: {})) {
        self.timeInterval = timeInterval
        self.queue = queue
        self.dispatchWorkItem = dispatchWorkItem
    }
    
    func dispatch(_ block: @escaping () -> Void) {
        dispatchWorkItem.cancel()
        let workItem = DispatchWorkItem {
            block()
        }
        dispatchWorkItem = workItem
        queue.asyncAfter(deadline: .now() + 0.3, execute: dispatchWorkItem)
    }
}
