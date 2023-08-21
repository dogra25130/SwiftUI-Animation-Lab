//
//  RecipeDishes.swift
//  Avocados
//
//  Created by Abhishek Dogra on 11/06/23.
//

import SwiftUI

struct RecipeDishes: View {
    var body: some View {
            HStack {
                VStack {
                    VStack(spacing: 0) {
                        HStack {
                            Image("icon-toasts")
                                .resizable()
                                .scaledToFit()
                                .modifier(IconModifier())
                            Spacer()
                            Text("Toasts")
                        }
                        Divider()
                        HStack {
                            Image("icon-tacos")
                                .resizable()
                                .scaledToFit()
                                .modifier(IconModifier())
                            Spacer()
                            Text("Tacos")
                        }
                        Divider()
                        HStack {
                            Image("icon-salads")
                                .resizable()
                                .scaledToFit()
                                .modifier(IconModifier())
                            Spacer()
                            Text("Salads")
                        }
                        Divider()
                        HStack {
                            Image("icon-halfavo")
                                .resizable()
                                .scaledToFit()
                                .modifier(IconModifier())
                            Spacer()
                            Text("Spreads")
                        }
                    }
                }
                
                VStack {
                    HStack {
                      Divider()
                    }
                    
                    Image(systemName: "heart.circle")
                      .font(Font.title.weight(.ultraLight))
                      .imageScale(.large)
                    
                    HStack {
                      Divider()
                    }
                }
                
                VStack {
                    VStack(spacing: 0) {
                        HStack {
                            Text("Guacamole")
                            Spacer()
                            Image("icon-guacamole")
                                .resizable()
                                .scaledToFit()
                                .modifier(IconModifier())
                        }
                        Divider()
                        HStack {
                            Text("Sandwich")
                            Spacer()
                            Image("icon-sandwiches")
                                .resizable()
                                .scaledToFit()
                                .modifier(IconModifier())
                            
                            
                        }
                        Divider()
                        HStack {
                            Text("Soup")
                            Spacer()
                            Image("icon-soup")
                                .resizable()
                                .scaledToFit()
                                .modifier(IconModifier())
                        }
                        Divider()
                        HStack {
                            Text("Smoothie")
                            Spacer()
                            Image("icon-smoothies")
                                .resizable()
                                .scaledToFit()
                                .modifier(IconModifier())
                        }
                    }
                }
            }
            .font(.system(.callout, design: .serif))
            .foregroundColor(Color.gray)
            .padding(.horizontal)
        .frame(maxHeight: 150)
    }
}

struct IconModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .frame(width: 42, height: 42, alignment: .center)
  }
}


struct RecipeDishes_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDishes()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
