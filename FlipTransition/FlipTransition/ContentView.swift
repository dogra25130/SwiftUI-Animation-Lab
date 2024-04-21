//
//  ContentView.swift
//  FlipTransition
//
//  Created by Abhishek Dogra on 21/04/24.
//

import SwiftUI


struct ContentView: View {
    let viewModel = ViewModel()
    private var data  = Array(1...20)
    private let adaptiveColumn = [GridItem(.flexible(), spacing: 5),
                                  GridItem(.flexible(), spacing: 5)]
    @State var selectedElement: Data?
    @State var shouldFlip: Bool = true
    @State private var angle: Double = 0.0
    @Namespace var namespace
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                let size = proxy.size
                ZStack {
                    ScrollView {
                        LazyVGrid(columns: adaptiveColumn, spacing: 5) {
                            ForEach(viewModel.dataArray, id: \.id) { data in
                                Text(data.isRevealed ? data.revealedText : data.unrevealedText)
                                    .font(data.isRevealed ? .body : .title)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .aspectRatio(1.0, contentMode: .fit)
                                    .background(data.isRevealed ? Color.red.gradient : Color.blue.gradient)
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                                    .font(.title)
                                    
                                    .onTapGesture {
                                        withAnimation {
                                            selectedElement = data
                                        }
                                    }
                                    .matchedGeometryEffect(id: data.id, in: namespace)
                            }
                        }
                        
                    }
                    .navigationTitle("Pick a card for interesting facts")
                    .navigationBarTitleDisplayMode(.inline)
                    if let selectedElement {
                        RoundedRectangle(cornerRadius: 0).fill(.ultraThinMaterial)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation {
                                    shouldFlip = true
                                    self.selectedElement = nil
                                }
                            }
                        
                        ZStack {
                            Group {
                                if selectedElement.isRevealed {
                                    Text(selectedElement.revealedText)
                                        .font(selectedElement.isRevealed ? .body : .title)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .frame(width: size.width / 2,
                                               height: size.width / 2)
                                        .aspectRatio(1.0, contentMode: .fit)
                                        .background(Color.red.gradient)
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .onTapGesture {
                                            withAnimation {
                                                shouldFlip = true
                                                self.selectedElement = nil
                                            }
                                        }
                                } else {
                                    if shouldFlip {
                                        Text(selectedElement.unrevealedText)
                                            .transition(.flip)
                                            .font(.title)
                                            .multilineTextAlignment(.center)
                                            .padding()
                                            .frame(width: size.width / 2,
                                                   height: size.width / 2)
                                            .aspectRatio(1.0, contentMode: .fit)
                                            .background(Color.blue.gradient)
                                            .cornerRadius(10)
                                            .foregroundColor(.white)
                                            .font(.title)
                                            
                                            .onTapGesture {
                                                withAnimation(.bouncy(duration: 2)) {
                                                    if let index = viewModel.dataArray.firstIndex(where: { $0.id == selectedElement.id }) {
                                                        viewModel.dataArray[index].isRevealed = true
                                                    }
                                                    shouldFlip = false
                                                }
                                            }

                                    } else {
                                        Text(selectedElement.revealedText)
                                            .transition(.reverseFlip)
                                            .font(.body)
                                            .multilineTextAlignment(.center)
                                            .padding()
                                            .frame(width: size.width / 2,
                                                   height: size.width / 2)
                                            .aspectRatio(1.0, contentMode: .fit)
                                            .background(Color.red.gradient)
                                            .cornerRadius(10)
                                            .foregroundColor(.white)
                                            .font(.title)
                                            
                                            .onTapGesture {
                                                withAnimation {
                                                    self.selectedElement = nil
                                                }
                                            }
                                        
                                    }
                                }
                            }
                            .matchedGeometryEffect(id: selectedElement.id,
                                                   in: namespace)
                        }
                    }
                }
                
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}

struct FlipTransition: ViewModifier {
    var progress: CGFloat = 0
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    func body(content: Content) -> some View {
        content
            .opacity(progress < 0 ? (-progress < 0.5 ? 1 : 0) : (progress < 0.5 ? 1 : 0))
            .rotation3DEffect(
                .init(degrees: progress * 180),
                      axis: (x: 0.0, y: 1.0, z: 0.0)
            )
    }
}

extension AnyTransition {
    static let flip: AnyTransition = .modifier(active: FlipTransition(progress: 1), identity: FlipTransition())
    static let reverseFlip: AnyTransition = .modifier(active: FlipTransition(progress: -1), identity: FlipTransition())
}


struct Data: Identifiable {
    let id = UUID()
    let unrevealedText: String
    let revealedText: String
    var isRevealed: Bool = false
}

class ViewModel {

    let interestingFacts = [
        "The human heart beats over 100,000 times a day.",
        "Honey never spoils.",
        "Bananas are berries.",
        "Octopuses have three hearts.",
        "The shortest war in history lasted 38 minutes.",
        "The Eiffel Tower can grow taller in the summer.",
        "Birds are dinosaurs' closest living relatives.",
        "The Great Wall of China is not visible from space.",
        "Your brain generates about 12-25 watts of electricity.",
        "There's a planet where it rains glass sideways.",
        "Cows have best friends.",
        "The unicorn is Scotland’s national animal.",
        "The longest time between two twins being born is 87 days.",
        "Some cats are allergic to humans.",
        "The world's smallest bone is in the ear.",
        "Koalas have fingerprints.",
        "Cats can make over 100 different sounds.",
        "A day on Venus is longer than a year.",
        "Baby elephants suck their trunks for comfort.",
        "A group of flamingos is called a flamboyance."
    ]

    var dataArray: [Data] = []
    init() {
        for i in 1...20 {
            let data = Data(
                unrevealedText: "\(i)",
                revealedText: interestingFacts[i - 1]
            )
            dataArray.append(data)
        }
    }
}
