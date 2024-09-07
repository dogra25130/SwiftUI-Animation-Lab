//
//  HomeShimmerView.swift
//  PCast
//
//  Created by Abhishek Dogra on 25/08/24.
//

import SwiftUI
struct HomeShimmerView: View {
    @State private var offset: CGFloat = -1.0

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 150)
                .padding(.top, 100)
                .shimmer(when: .constant(true))
            HStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 100)
                VStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 200, height: 20)
                    
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 100, height: 20)
                    
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 50, height: 20)
                }
            }
            .shimmer(when: .constant(true))
            HStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 100)
                VStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 200, height: 20)
                    
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 100, height: 20)
                    
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 50, height: 20)
                }
            }
            .shimmer(when: .constant(true))
            HStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 100)
                VStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 200, height: 20)
                    
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 100, height: 20)
                    
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 50, height: 20)
                }
            }
            .shimmer(when: .constant(true))
            HStack(spacing: 20) {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 50, height: 50)
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 50, height: 50)
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 50, height: 50)
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 50, height: 50)
            }
            .shimmer(when: .constant(true))
            HStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 100)
                VStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 200, height: 20)
                    
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 100, height: 20)
                    
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 50, height: 20)
                }
            }
            .shimmer(when: .constant(true))
        }
        .padding()
    }
}
