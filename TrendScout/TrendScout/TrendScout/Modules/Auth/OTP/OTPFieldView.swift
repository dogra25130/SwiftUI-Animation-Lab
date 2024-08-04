//
//  OTPFieldView.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 17/07/24.
//

import SwiftUI
enum UserRegisterationState {
    case registered
    case unregistered
}
public struct OTPFieldView: View {
    
    private var activeIndicatorColor: Color
    private var inactiveIndicatorColor: Color
    private let otpEntered: (String) -> Void
    private let length: Int
    
    @State private var otpText = ""
    @FocusState private var isKeyboardShowing: Bool
    
    public init(activeIndicatorColor: Color,
                inactiveIndicatorColor: Color,
                length: Int,
                otpEntered: @escaping (String) -> Void) {
        self.activeIndicatorColor = activeIndicatorColor
        self.inactiveIndicatorColor = inactiveIndicatorColor
        self.length = length
        self.otpEntered = otpEntered
    }
    
    public var body: some View {
        HStack(spacing: .zero) {
            ForEach(.zero...length - 1, id: \.self) { index in
                OTPTextBox(index)
            }
        }.background(content: {
            TextField("", text: $otpText.limit(4))
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .frame(width: 1, height: 1)
                .opacity(0.001)
                .blendMode(.screen)
                .focused($isKeyboardShowing)
                
                .onChange(of: otpText) { _, newValue in
                    if newValue.count == length {
                        otpEntered(newValue)
                    }
                }
                .onAppear {
                    DispatchQueue.main.async {
                        isKeyboardShowing = true
                    }
                }
        })
        .contentShape(Rectangle())
        .onTapGesture {
            isKeyboardShowing = true
        }
    }
    
    @ViewBuilder
    func OTPTextBox(_ index: Int) -> some View {
        ZStack{
            if otpText.count > index {
                let startIndex = otpText.startIndex
                let charIndex = otpText.index(startIndex, offsetBy: index)
                let charToString = String(otpText[charIndex])
                Text(charToString)
            } else {
                Text(" ")
            }
        }
        .frame(width: 45, height: 45)
        .background {
            let status = (isKeyboardShowing && otpText.count == index)
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(status ? activeIndicatorColor : inactiveIndicatorColor)
                .animation(.easeInOut(duration: 0.2), value: status)
                .shadow(color: .white, radius: status ? .r4 : .zero)
                .overlay {
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .foregroundStyle(Color.gray.opacity(0.2))
                }

        }
        .padding()
    }
}

extension Binding where Value == String {
    func limit(_ length: Int)->Self {
        if self.wrappedValue.count > length {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPFieldView(activeIndicatorColor: Color.black, inactiveIndicatorColor: Color.gray,  length: 4, otpEntered: { value in
            
        })
        .padding()
    }
}
