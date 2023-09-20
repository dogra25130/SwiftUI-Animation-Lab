//
//  PeelEffect.swift
//  PeelAnimation
//
//  Created by Abhishek Dogra on 15/09/23.
//

import SwiftUI

struct PeelEffect<Content: View>: View {
    var content: Content
    var onDelete: () -> ()
    var couponCode: String
    init(@ViewBuilder content: @escaping () -> Content, onDelete: @escaping () -> Void, couponCode: String) {
        self.content = content()
        self.onDelete = onDelete
        self.couponCode = couponCode
    }
    
    @State private var dragProgress: CGFloat = 0
    var body: some View {
        content
            .mask {
                GeometryReader {
                    let rect = $0.frame(in: .global)
                    
                    Rectangle()
                        .padding(.trailing, dragProgress * rect.width)
                }
            }
            .overlay {
                GeometryReader {
                    let size = $0.size
                    let minOpacity = dragProgress / 0.05
                    let opacity = min(1, minOpacity)
                    content
                        .shadow(color: .black.opacity(dragProgress != 0 ? 0.1 : 0), radius: 5, x: 15, y: 0)
                        .overlay(content: {
                            Rectangle()
                                .fill(.white.opacity(0.25))
                                .mask(content)
                        })
                        .overlay(alignment: .trailing) {
                            Rectangle()
                                .fill(
                                    .linearGradient(colors: [.clear, .white, .clear, .clear],
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                    )
                                )
                                .frame(width: 60)
                                .offset(x: 40)
                                .offset(x: -30 + (30 * opacity))
                                .offset(x: size.width * -dragProgress)
                        }
                        .scaleEffect(x: -1)
                        .offset(x: size.width - (size.width * dragProgress))
                        .offset(x: size.width * -dragProgress)
                        .mask({
                            Rectangle()
                                .offset(x: size.width * -dragProgress)
                        })
                        .contentShape(Rectangle())
                        
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    var transitionX = value.translation.width
                                    
                                    transitionX = max(-transitionX, .zero)
                                    
                                    let progress = min(1, transitionX / size.width)
                                    
                                    dragProgress = progress
                                }).onEnded({ value in
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                        if dragProgress > 0.25 {
                                            dragProgress = 0.6
                                        } else {
                                            dragProgress = .zero
                                        }
                                        
                                    }
                                })
                        )
                        
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                        dragProgress = .zero
                    }
                }
            }
            .background {
                GeometryReader {
                    let rect = $0.frame(in: .global)
                    
                    Rectangle()
                        .fill(.black)
                        .padding(.vertical, 23)
                        .shadow(color: .black.opacity(0.3), radius: 15, x: 30, y: 0)
                        .padding(.trailing, rect.width * dragProgress)
                }
                .mask(content)
            }
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color(hex: "FF6B6B").gradient)
                    .overlay(alignment: .trailing) {
                        Button {
                            
                        } label: {
                            Text(couponCode)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.trailing, 20)
                                .foregroundColor(.white)
                        }

                    }
                    .padding(.vertical, 8)
            }
    }
}

struct PeelEffect_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
