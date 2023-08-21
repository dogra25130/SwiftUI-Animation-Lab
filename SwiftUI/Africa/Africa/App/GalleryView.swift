//
//  GalleryView.swift
//  Africa
//
//  Created by Abhishek Dogra on 04/06/23.
//

import SwiftUI

struct GalleryView: View {
    @State private var selected: String = "lion"
    let animals: [Animal] = Bundle.main.decode("animals.json")

//    let gridLayout: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    @State private var gridLayout: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    @State private var gridColumn: Double = 3.0
    
    func gridSwitch() {
        gridLayout = Array(repeating: GridItem(.flexible()), count: Int(gridColumn))
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 15) {
                Image(selected)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 8))

                
                Slider(value: $gridColumn, in: 2...4, step: 1)
                    .padding(.horizontal)
                    .onChange(of: gridColumn) { newValue in
                        withAnimation(.easeIn, {
                            gridSwitch()
                        })
                        
                    }
                
                LazyVGrid(columns: gridLayout) {
                    ForEach(animals) { item in
                        Image(item.image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                            .onTapGesture {
                                selected = item.image
                            }
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 50)
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(MotionAnimationView())
        .onAppear {
            gridSwitch()
        }
//        .edgesIgnoringSafeArea(.all)
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
