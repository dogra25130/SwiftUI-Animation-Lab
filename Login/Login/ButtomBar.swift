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
                Label("Continue with Apple", systemImage: "applelogo")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(.white, in: RoundedRectangle(cornerRadius: 12))
            }
            Button {
                
            } label: {
                Label("Continue with Phone", systemImage: "phone.fill")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(.gray, in: RoundedRectangle(cornerRadius: 12))
            }
            Button {
                
            } label: {
                Label("Signup with Email", systemImage: "envelope.fill")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(.gray, in: RoundedRectangle(cornerRadius: 12))
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
