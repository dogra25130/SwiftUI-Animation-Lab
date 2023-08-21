//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Abhishek Dogra on 10/06/23.
//

import SwiftUI
#if canImport(UIKit)

extension UIView {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#endif
