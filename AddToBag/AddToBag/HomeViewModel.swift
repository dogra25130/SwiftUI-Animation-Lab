//
//  HomeViewModel.swift
//  AddToBag
//
//  Created by Abhishek Dogra on 03/03/24.
//

import SwiftUI
class HomeViewModel: ObservableObject {
    @Published var showCart = false
    @Published var selectedSize = ""
    @Published var startAnimation = false
    @Published var shoeAnimation = false
    @Published var saveCart = false
    @Published var addItemToCart = false
    @Published var endAnimation = false
    @Published var showBag = false
    @Published var cartItems = 0
    func performAnimation() {
        withAnimation(.easeOut(duration: 0.8)) {
            shoeAnimation.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            withAnimation(.easeInOut) {
                self.showBag.toggle()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.saveCart.toggle()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            self.addItemToCart.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.endAnimation.toggle()
            }
        }
    }
    
    func resetAll() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
            withAnimation(.easeInOut) {
                showCart.toggle()
            }
            selectedSize = ""
            startAnimation = false
            shoeAnimation = false
            saveCart = false
            addItemToCart = false
            endAnimation = false
            showBag = false
            cartItems += 1
        }
    }
}
