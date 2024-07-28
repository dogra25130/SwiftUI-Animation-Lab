//
//  Fonts.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 28/07/24.
//

import SwiftUI

enum FontWeight: String {
    case thin100 = "Poppins-Thin"
    case extraLight200 = "Poppins-ExtraLight"
    case light300 = "Poppins-Light"
    case regular400 = "Poppins-Regular"
    case medium500 = "Poppins-Medium"
    case semiBold600 = "Poppins-SemiBold"
    case bold700 = "Poppins-Bold"
    case extraBold800 = "Poppins-ExtraBold"
    case black900 = "Poppins-Black"
    case thinItalic100 = "Poppins-ThinItalic"
    case extraLightItalic200 = "Poppins-ExtraLightItalic"
    case lightItalic300 = "Poppins-LightItalic"
    case italic400 = "Poppins-Italic"
    case mediumItalic500 = "Poppins-MediumItalic"
    case semiBoldItalic600 = "Poppins-SemiBoldItalic"
    case boldItalic700 = "Poppins-BoldItalic"
    case extraBoldItalic800 = "Poppins-ExtraBoldItalic"
    case blackItalic900 = "Poppins-BlackItalic"
}

extension Font {
    static func setFont(_ fontType: FontWeight, _ size: CGFloat) -> Font {
        return Font.custom(fontType.rawValue, size: size)
    }
}
