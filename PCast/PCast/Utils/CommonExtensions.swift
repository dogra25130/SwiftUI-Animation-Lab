//
//  CommonExtensions.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/08/24.
//

import Foundation
import SwiftUI

extension Optional {
    var isNil: Bool {
        self == nil
    }
}
extension View {
    func applyHomeShimmerView(isLoading: Bool) -> some View {
        self.overlay {
            if isLoading {
                HomeShimmerView()
            }
        }
    }
    func applyPodCastShimmerView(isLoading: Bool) -> some View {
        self.overlay {
            if isLoading {
                PodCastShimmerView()
            }
        }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
