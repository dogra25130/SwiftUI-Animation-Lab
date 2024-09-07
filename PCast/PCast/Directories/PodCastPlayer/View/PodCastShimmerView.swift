//
//  PodCastShimmerView.swift
//  PCast
//
//  Created by Abhishek Dogra on 25/08/24.
//

import SwiftUI
struct PodCastShimmerView: View {
    @State private var offset: CGFloat = -1.0

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 700)
                .shimmer(when: .constant(true))
                .padding(.bottom, 20)
            
            UnevenRoundedRectangle(topLeadingRadius: 24,
                                   bottomLeadingRadius: .zero,
                                   bottomTrailingRadius: .zero,
                                   topTrailingRadius: 24,
                                   style: .circular)
            .frame(height: 50)
            .offset(y: -50)
            
            HStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.gray.opacity(0.3))
                    .frame(maxWidth: 100)
                    .frame(height: 50)
                    .shimmer(when: .constant(true))
                    .padding()
                    .offset(y: -50)
                
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.gray.opacity(0.3))
                    .frame(maxWidth: 100)
                    .frame(height: 50)
                    .shimmer(when: .constant(true))
                    .padding()
                    .offset(y: -50)
                
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.gray.opacity(0.3))
                    .frame(maxWidth: 100)
                    .frame(height: 50)
                    .shimmer(when: .constant(true))
                    .padding()
                    .offset(y: -50)
                
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.gray.opacity(0.3))
                    .frame(maxWidth: 100)
                    .frame(height: 50)
                    .shimmer(when: .constant(true))
                    .padding()
                    .offset(y: -50)
            }
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.gray.opacity(0.3))
                .frame(maxWidth: .infinity)
                .frame(height: 2)
                .shimmer(when: .constant(true))
                .padding()
                .offset(y: -50)
            
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.gray.opacity(0.3))
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .shimmer(when: .constant(true))
                .padding()
                .offset(y: -50)
            
            VStack {
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
            .offset(y: -50)
            .padding()
            Spacer()
        }
        .foregroundStyle(Color.black)
        .ignoresSafeArea()
    }
}

#Preview(body: {
    PodCastShimmerView()
})
