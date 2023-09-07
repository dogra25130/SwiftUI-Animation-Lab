//
//  ContentView.swift
//  VideoPlayerCollection
//
//  Created by Abhishek Dogra on 06/09/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var videoManager = VideoManager()
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    @State var selectedTag: Query = .nature

    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                VStack {
                    Picker("", selection: $selectedTag) {
                        ForEach(Query.allCases, id: \.self) { queryTag in
                            QueryTag(query: queryTag, isSelected: videoManager.selectedQuery == selectedTag)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .onChange(of: selectedTag) { newValue in
                        videoManager.video = []
                        videoManager.selectedQuery = newValue
                    }

                    ScrollView {
                        if videoManager.video.isEmpty {
                            ProgressView("Fetching data...")
                                .frame(height: 120, alignment: .center)
                                .font(.body)
                                .bold()
                        } else {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(videoManager.video, id: \.id) { video in
                                    NavigationLink {
                                        VideoView(video: video)
                                    } label: {
                                        VideoCard(video: video)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .toolbar(.hidden)
            }
        }
    }
}



struct BackgroundView: View {
    @State private var startAnimation: Bool = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#03001e"),Color(hex: "#1CB5E0"),Color(hex: "#24243e")],
                startPoint: startAnimation ? .topLeading : .bottomLeading,
                endPoint: startAnimation ? .bottomLeading : .topTrailing
            )
            .onAppear {
                withAnimation(.linear(duration: 5.0).repeatForever()) {
                    startAnimation.toggle()
                }
            }
            
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
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
