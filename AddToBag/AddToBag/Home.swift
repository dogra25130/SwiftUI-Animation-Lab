//
//  Home.swift
//  AddToBag
//
//  Created by Abhishek Dogra on 03/03/24.
//

import SwiftUI

struct Plant {
    var id = UUID()
    var image: String
    var title: String
    var desc: String
    var price: String
}


struct Home: View {
    @StateObject var homeData = HomeViewModel()
    @Namespace var animation
    @State var selectedPlant: Plant =  Plant(image: "1",
                                             title: "Quixotica Glitterfern",
                                             desc: "A luminescent fern with holographic fronds that emit a soft glow, creating an enchanting and surreal ambiance in any garden.",
                                             price: "₹3,490")
    let plants = [Plant(image: "1",
                        title: "Quixotica Glitterfern",
                        desc: "A luminescent fern with holographic fronds that emit a soft glow, creating an enchanting and surreal ambiance in any garden.",
                        price: "₹3,490"),
                  Plant(image: "2",
                        title: "Nebula Whisperblossom",
                        desc: " This otherworldly flower releases ethereal whispers as it blooms, its petals adorned with miniature, swirling nebula patterns, bringing a touch of cosmic mystique to botanical landscapes.",
                        price: "₹4,490"),
                  Plant(image: "3",
                        title: "Zephyr Synchronettle",
                        desc: "A whimsical plant that responds to the breeze, its delicate leaves dance synchronously with the wind, creating a mesmerizing choreography of motion and adding an element of natural grace to outdoor spaces.",
                        price: "₹5,490")]
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "rectangle.3.offgrid.fill")
                            .foregroundStyle(Color.black)
                    }
                    Spacer()
                    Text("Buy Plants")
                        .font(.title)
                        .bold()
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "bag.fill")
                            .foregroundStyle(Color.white)
                            .padding(10)
                            .background(Color.purple)
                            .clipShape(Circle())
                            .overlay {
                                Text("\(homeData.cartItems)")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.white)
                                    .padding(10)
                                    .background(Color.green)
                                    .clipShape(Circle())
                                    .offset(x: 15, y: -10)
                                    .opacity(homeData.cartItems != 0 ? 1 : 0)
                            }
                        
                    }
                }
                .padding()
                ScrollView {
                    VStack(spacing: 16) {
                        
                        
                        ForEach(plants, id: \.id) { plant in
                            VStack(alignment: .leading, spacing: 10) {
                                HStack(spacing: .zero) {
                                    Capsule()
                                        .fill(Color.green)
                                        .frame(width: 4)
                                    VStack(alignment: .leading) {
                                        Text(plant.title)
                                            .font(.title2)
                                            .bold()
                                            .foregroundStyle(Color.black)
                                        
                                        Text(plant.desc)
                                            .bold()
                                            .foregroundStyle(Color.gray)
                                        
                                    }
                                    .padding(.horizontal)
                                }
                                
                                Group {
                                    Image(plant.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .padding(.horizontal, 30)
                                        .foregroundColor(.white)
                                        .shadow(radius: 4)
                                    
                                    Text("Price")
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.gray)
                                    
                                    Text(plant.price)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color.green)
                                }
                                .padding(.horizontal)
                            }
                            .padding(.vertical, 20)
                            .background(Color.black.opacity(0.06))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding()
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    selectedPlant = plant
                                    homeData.showCart.toggle()
                                }
                            }
                        }
                    }
                }
            }
            .blur(radius: homeData.showCart ? 25 : 0)
            
            
            AddToCartView(animation: animation, selectedPlant: selectedPlant)
                .environmentObject(homeData)
                .clipShape(
                    .rect(
                        topLeadingRadius: 35,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 00,
                        topTrailingRadius: 35
                    )
                )
                .offset(y: homeData.showCart ? (homeData.startAnimation ? 500 : 0) : 500)
            
            if homeData.startAnimation {
                VStack {
                    Spacer()
                    ZStack {
                        Color.white
                            .frame(width: homeData.shoeAnimation ? 100 : getRect().width * 1.3,
                                   height: homeData.shoeAnimation ? 100 : getRect().width * 1.3)
                            .clipShape(Circle())
                        
                            .opacity(homeData.shoeAnimation ? 1 : 0)
                        Image(selectedPlant.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 50)
                            .foregroundColor(.white)
                            .shadow(radius: 4)
                            .padding(.horizontal)
                            .matchedGeometryEffect(id: "Air tag", in: animation)
                        
                        
                    }
                    .offset(y: homeData.saveCart ? 70 : -120)
                    .scaleEffect(homeData.saveCart ? 0.6 : 1)
                    .onAppear {
                        homeData.performAnimation()
                    }
                    
                    if !homeData.saveCart {
                        Spacer()
                    }
                    
                    Image(systemName: "bag\(homeData.addItemToCart ? ".fill" : "")")
                        .font(.title)
                        .foregroundStyle(Color.white)
                        .padding()
                        .background(homeData.addItemToCart ? Color.purple : Color.green)
                        .clipShape(Circle())
                        .offset(y: homeData.showBag ? -50 : 300)
                    
                }
                .frame(width: getRect().width)
                .offset(y: homeData.endAnimation ? 500 : 0)
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color.black.opacity(0.04).ignoresSafeArea())
        .onChange(of: homeData.endAnimation) { before, after in
            if after {
                homeData.resetAll()
            }
        }
    }
}

#Preview {
    Home()
}

struct AddToCartView: View {
    @EnvironmentObject var homeData: HomeViewModel
    var animation: Namespace.ID
    var selectedPlant: Plant
    var body: some View {
        VStack {
            HStack {
                if !homeData.startAnimation {
                    Image(selectedPlant.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 50)
                        .foregroundColor(.white)
                        .shadow(radius: 4)
                        .padding(.horizontal)
                        .matchedGeometryEffect(id: "Air tag", in: animation)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 10) {
                    Text(selectedPlant.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.gray)
                        .multilineTextAlignment(.trailing)
                    
                    Text(selectedPlant.price)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                }
            }
            .padding(.vertical)
            
            Divider()
            
            Text("SELECT QUANTITY")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(Color.gray)
                .padding(.top)
            let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 4)
            LazyVGrid(columns: columns, alignment: .leading, spacing: 15) {
                ForEach(sizes, id: \.self) { size in
                    Button {
                        withAnimation {
                            homeData.selectedSize = size
                        }
                    } label: {
                        Text(size)
                            .fontWeight(.semibold)
                            .foregroundStyle(homeData.selectedSize == size ? .white : .black)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(homeData.selectedSize == size ? Color.green : Color.black.opacity(0.06))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
            }
            
            Button {
                withAnimation(.easeInOut(duration: 0.7)) {
                    homeData.startAnimation.toggle()
                }
            } label: {
                Text("Add to cart")
                    .fontWeight(.bold)
                    .foregroundStyle(homeData.selectedSize == "" ? .black : .white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(homeData.selectedSize == ""  ? Color.black.opacity(0.06) : Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            .disabled(homeData.selectedSize == "")
            .padding(.top)
        }
        .padding()
        .padding(.bottom, 10)
        .background(Color.white)
    }
}

let sizes = ["Pack \n of 2", "Pack \n of 4", "Pack \n of 6", "Pack \n of 10"]

extension View {
    func getRect() -> CGRect {
        UIScreen.main.bounds
    }
}
