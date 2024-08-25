//
//  PButtons.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/08/24.
//

import SwiftUI

struct PButton: View {
    let title: String
    let color: Color
    var font: Font = .setFont(.medium500, 16)
    var buttonStyle = BounceButtonStyle()
    @Binding var isLoading: Bool
    @State var cornerRadius: CGFloat = .zero
    @State private var size: CGSize = .zero
    let onTapped: () -> ()
    
    init(title: String,
         color: Color,
         font: Font = .setFont(.medium500, 16),
         buttonStyle: BounceButtonStyle = BounceButtonStyle(),
         isLoading: Binding<Bool> = .constant(false),
         onTapped: @escaping () -> ()) {
        self.title = title
        self.color = color
        self.font = font
        self.buttonStyle = buttonStyle
        self._isLoading = isLoading
        self.onTapped = onTapped
    }
    
    var body: some View {
        Button {
            isLoading.toggle()
            onTapped()
        } label: {
            Group {
                if !isLoading {
                    Text(title)
                        .font(font)
                        .background(GeometryReader { proxy in
                            Color.clear.preference(
                                key: ButtonSizePreferenceKey.self,
                                value: proxy.size
                            )
                        })
                } else {
                    ProgressView()
                        .frame(height: size.height)
                }
            }
            .foregroundStyle(Color.white)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundStyle(color)
            )
        }
        .background(
            GeometryReader { proxy in
                Color.clear.onAppear {
                    cornerRadius = proxy.size.height / 2.5
                }
            }
        )
        .buttonStyle(buttonStyle)
        .onPreferenceChange(ButtonSizePreferenceKey.self, perform: { value in
            if size == .zero {
                size = value
            }
        })
        
    }
}

struct PButtonUnderline: View {
    var text: String
    let onTapped: () -> ()
    var body: some View {
        Button {
            onTapped()
        } label: {
            Text(text)
                .underline()
                .foregroundStyle(Color.gray)
        }
    }
}

struct ButtonSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        defaultValue = nextValue()
    }
}

struct BounceButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
    }
}

extension View {
    func addBounceButtonStyle() -> some View {
        buttonStyle(BounceButtonStyle())
    }
}
