//
//  PodcastCellView.swift
//  PCast
//
//  Created by Abhishek Dogra on 24/08/24.
//

import SwiftUI
extension PodcastPlayer {
    func PodcastCellView(for model: PodCastModel) -> some View {
        VStack {
            HStack(spacing: .zero) {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 32)
                    .overlay {
                        Image(systemName: "play")
                            .resizable()
                            .frame(width: 10, height: 12)
                            .foregroundStyle(Color.white)
                            .bold()
                            .offset(x: 1)
                    }
                    .padding(.trailing, 16)
                
                VStack(alignment: .leading) {
                    Text(model.title)
                        .font(.setFont(.regular400, 14))
                        .foregroundStyle(Color.white)
                    Text(model.date)
                        .foregroundStyle(Color(hex: "898F97"))
                        .font(.setFont(.regular400, 12))
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(model.duration)
                        .font(.setFont(.regular400, 12))
                    Text(model.size)
                        .font(.setFont(.regular400, 12))
                }
                .foregroundStyle(Color(hex: "898F97"))
                .padding(.trailing, 16)
                
                Button {
                    viewModel.startDownload(model)
                } label: {
                    Group {
                        if viewModel.inDownloadingQueue(model) {
                            if viewModel.isDownloading(model) {
                                CircularProgressView(progress: viewModel.currentDownloadingProgress)
                            } else {
                                ProgressView()
                            }
                        } else {
                            if viewModel.isDownloaded(model) {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .foregroundStyle(Color.green,
                                                     Color(hex: "459221").opacity(0.15))
                            } else {
                                Circle()
                                    .fill(Color(hex: "19232F"))
                                    .frame(width: 32)
                                    .overlay {
                                        Image(systemName: "square.and.arrow.down")
                                            .resizable()
                                            .frame(width: 16, height: 16)
                                            .foregroundStyle(Color.white)
                                            .bold()
                                    }
                            }
                        }
                    }
                }
                .frame(width: 20)
            }
            .padding(16)
        }
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(hex: "070D15"))
        }
    }
}

#Preview {
    PodcastPlayer(viewModel: PodCastViewModel(model: PodCastModel(id: "", title: "", date: "", duration: "", authorName: "", image: "", size: "", url: "")))
}

struct CircularProgressView: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.blue.opacity(0.5),
                    lineWidth: 8
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.blue,
                    style: StrokeStyle(
                        lineWidth: 4,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
            
        }
    }
}
