//
//  PTextField.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/08/24.
//

import SwiftUI
enum PTextFieldType {
    case email
    case password
    case other
    
    func getPlaceHolderText() -> String {
        switch self {
        case .email:
            return "E-mail address"
        case .password:
            return "Password"
        case .other:
            return ""
        }
    }
    
    func shouldShowIcon() -> Bool {
        return self != .other
    }
    
    @ViewBuilder
    var Icon: some View {
        switch self {
        case .email:
            Image(systemName: "envelope")
        case .password:
            Image(systemName: "key")
                .rotationEffect(.degrees(45))
        case .other:
            EmptyView()
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        default:
            return .default
        }
    }
}

struct PTextField: View {
    @State var text: String = ""
    var textFieldType: PTextFieldType = .password
    var body: some View {
        HStack(spacing: 24) {
            textFieldType.Icon
                .foregroundStyle(Color.gray.opacity(0.6))
            Group {
                if textFieldType == .password {
                    SecureField(textFieldType.getPlaceHolderText(), text: $text)
                } else {
                    TextField(textFieldType.getPlaceHolderText(), text: $text)
                }
            }
            .font(.setFont(.regular400, 14))
            .keyboardType(textFieldType.keyboardType)
        }
        .padding(16)
        .overlay(
            UnevenRoundedRectangle(topLeadingRadius: 24, bottomLeadingRadius: 24, bottomTrailingRadius: .zero, topTrailingRadius: 24, style: .circular)
                .stroke()
        )
    }
}
