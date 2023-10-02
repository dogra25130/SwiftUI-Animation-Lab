//
//  ContentView.swift
//  CustomCarouselCards
//
//  Created by Abhishek Dogra on 01/10/23.
//

import SwiftUI

struct ContentView: View {
    @State private var startAnimation: Bool = false
    @State var index: Int = 0
    @State var isRotating = 0.0

    @State var stories: [Story] = [
        Story(id: 0, image: "1", offset: 0, title: "Emily Johnson", color: .red),
        Story(id: 1, image: "2", offset: 0, title: "Liam Smith", color: .cyan),
        Story(id: 2, image: "3", offset: 0, title: "Olivia Martinez", color: .blue),
        Story(id: 3, image: "4", offset: 0, title: "Noah Williams", color: .pink),
        Story(id: 4, image: "5", offset: 0, title: "Sophia Davis", color: .green)
    ]
    
    @State var scrolled = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "sidebar.left")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                Spacer()
                
                HStack {
                    Text("Photos")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                
                // MARK: Card View
                ZStack {
                    
                    Text("Start again!")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .onTapGesture {
                            Task {
                                for story in stories.reversed() {
                                    await animate(duration: 0.05) {
                                        scrolled -= 1
                                        stories[story.id].offset = 0
                                    }
                                    
                                }
                                
                            }
                        }
                    
                    ForEach(stories.reversed()) { story in
                        HStack {
                            getCardView(story: story)
                        }
                        .contentShape(Rectangle())
                        .offset(x: story.offset)
                        .gesture(DragGesture().onChanged({ value in
                            stories[story.id].offset = value.translation.width
                        }).onEnded({ value in
                            withAnimation {
                                if value.translation.width < 0 {
                                    if value.translation.width < 180 {
                                        stories[story.id].offset = -(calculateWidth() + 60)
                                        scrolled += 1
                                    } else {
                                        stories[story.id].offset = 0
                                    }
                                }else {
                                    stories[story.id].offset = 0
                                }
                                
                            }
                        }))
                    }
                }
                .frame(height: (UIScreen.main.bounds.height / 2.5))
                .padding()
                
                Spacer()
            }
        }
        .background(
            getBackgroundView()
        )
    }
    
    @ViewBuilder
    func getCardView(story: Story) -> some View {
        let width = calculateWidth()
        let height = (UIScreen.main.bounds.height / 2.5) - CGFloat(story.id - scrolled) * 50
        Image(story.image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .cornerRadius(15)
            .overlay {
                ZStack {
                    HStack {
                        Spacer()
                        VStack {
                            Spacer()
                            Text(story.title)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        
                    }
                    .padding()
                    
                    if story.id != scrolled {
                        RoundedRectangle(cornerRadius: 15)
                            .edgesIgnoringSafeArea(.all)
                            .foregroundStyle(.ultraThinMaterial)
                            .frame(width: width, height: height)
                        let rem = (stories.count - scrolled - 1)
                        if rem > 1 {
                            Text("+\(rem) others")
                                .font(.body)
                                .fontWeight(.bold)
                        }
                    }
                    
                }
            }
            .offset(x: (story.id - scrolled) <= 2 ? CGFloat(story.id - scrolled) * 30 : 60)
        Spacer()
        
    }
    
    func calculateWidth() -> CGFloat {
        let screen = UIScreen.main.bounds.width - 30
        let width = screen - (2 * 30)
        return width
        
    }
    
    @ViewBuilder
    func getBackgroundView() -> some View {
        

            ZStack {
                LinearGradient(
                    colors: [Color(hex: "#000001"),
                             Color(hex: "#ffffff"),
                             Color(hex: "#c0c0c0"),
                             Color(hex: "#c0c0c0"),
                             Color(hex: "#ffffff"),
                             Color(hex: "#000001")],
                    startPoint: isRotating == 0.0 ? .bottomTrailing : .bottomTrailing,
                    endPoint: isRotating == 0.0 ? .topLeading : .bottomLeading
                )
                .onAppear {
                    withAnimation(.linear(duration: 5.0)
                        .repeatForever(autoreverses: true)) {
                        isRotating = 360.0
                    }
                }
                
            }

            .ignoresSafeArea()
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

struct Story: Identifiable {
    let id: Int
    let image: String
    var offset: CGFloat
    let title: String
    let color: Color
}



extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


extension View {
    func animate(duration: CGFloat, _ execute: @escaping () -> Void) async {
        await withCheckedContinuation { continuation in
            withAnimation(.easeInOut(duration: duration)) {
                execute()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                continuation.resume()
            }
        }
    }
}
