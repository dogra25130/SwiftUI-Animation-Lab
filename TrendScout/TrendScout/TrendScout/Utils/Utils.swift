//
//  Utils.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 14/07/24.
//

import Foundation
import SwiftUI

class Utils {
    static var textTheme = Color(hex: "000000")
    static var textThemeSecondary = Color(hex: "FFFFFF")
    static var topbarBackgroundTheme = Color(hex: "BFC9CA")
    static var themePrimaryGradientColor1 = Color(hex: "000000") // Black
    static var themePrimaryGradientColor2 = Color(hex: "4A4A4A") // Light Gray

    static var themePrimaryGradientTopTab = Color(hex: "F0F3F4") // Very Light Gray

    static var themeSecondaryBackgroundColor = Color(hex: "1B1B1B")


    static var themeSecondaryGradientColor1 = Color.clear
    static var themeSecondaryGradientColor2 = Color(hex: "000000") // Dark Gray

    
    static var keyboardHeight: CGFloat = 0
    static func getSafeAreaTop()->CGFloat {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        return (keyWindow?.safeAreaInsets.top) ?? 0
        
    }
}

extension View {
    func readIntrinsicContentSize(to size: Binding<CGSize>) -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(
                key: IntrinsicContentSizePreferenceKey.self,
                value: proxy.size
            )
        })
        .onPreferenceChange(IntrinsicContentSizePreferenceKey.self) {
            size.wrappedValue.width = $0.width
            size.wrappedValue.height = $0.height
            print($0)
        }
    }
}
extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
struct IntrinsicContentSizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

public extension CGFloat {
    
    static let p1: CGFloat = 1.0
    static let p2: CGFloat = 2.0
    static let p4: CGFloat = 4.0
    static let p6: CGFloat = 6.0
    static let p8: CGFloat = 8.0
    static let p10: CGFloat = 10.0
    static let p12: CGFloat = 12.0
    static let p14: CGFloat = 14.0
    static let p15: CGFloat = 15.0
    static let p18: CGFloat = 18.0
    static let p16: CGFloat = 16.0
    static let p20: CGFloat = 20.0
    static let p22: CGFloat = 22.0
    static let p24: CGFloat = 24.0
    static let p28: CGFloat = 28.0
    static let p32: CGFloat = 32.0
    static let p36: CGFloat = 36.0
    static let p40: CGFloat = 40.0
    static let p42: CGFloat = 42.0
    static let p44: CGFloat = 44.0
    static let p48: CGFloat = 48.0
    static let p52: CGFloat = 52.0
    static let p56: CGFloat = 56.0
    static let p58: CGFloat = 58.0
    static let p60: CGFloat = 60.0
    static let p72: CGFloat = 72.0
    static let p80: CGFloat = 80.0
    static let p90: CGFloat = 90.0
    static let p100: CGFloat = 100.0
    static let p106: CGFloat = 106.0
    static let p110: CGFloat = 110.0
    
    static let r2: CGFloat = 2.0
    static let r4: CGFloat = 4.0
    static let r6: CGFloat = 6.0
    static let r8: CGFloat = 8.0
    static let r10: CGFloat = 10.0
    static let r12: CGFloat = 12.0
    static let r14: CGFloat = 14.0
    static let r16: CGFloat = 16.0
    static let r24: CGFloat = 24.0
    static let r32: CGFloat = 32.0
    static let r40: CGFloat = 40.0
}
#Preview(body: {
    HomeScreen()
})
