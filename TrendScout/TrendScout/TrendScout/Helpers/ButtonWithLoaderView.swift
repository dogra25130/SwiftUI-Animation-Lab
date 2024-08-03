//
//  ButtonWithLoaderView.swift
//  TrendScout
//
//  Created by Abhishek Dogra on 20/07/24.
//

import SwiftUI
struct ButtonWithLoaderView: View {
    @Binding var isLoading: Bool
    var label: String
    var body: some View {
        Group {
            if isLoading {
                CircularLoaderView()
            } else {
                Text(label)
            }
        }
        .frame(minWidth: .zero, maxWidth: .infinity)
        .font(.system(size: .p18))
        .padding()
        .foregroundColor(.white)
    }
}
