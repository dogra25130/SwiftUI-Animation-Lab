//
//  BottomBar.swift
//  LoginPage
//
//  Created by Abhishek Dogra on 21/06/23.
//

import SwiftUI

struct BottomBar: View {
    var body: some View {
        VStack {
            Spacer()
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 60)
                        .foregroundColor(.white)
                    Text("Continue with Apple")
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 60)
                        .foregroundColor(.gray)
                    Text("Continue with Email")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 60)
                        .foregroundColor(.gray)
                    Text("Continue with Phone")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
            
        }
        .padding()
        .ignoresSafeArea()
        .cornerRadius(12)
    }
}

struct BottomBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomBar()
            .ignoresSafeArea()
            .padding()
    }
}
