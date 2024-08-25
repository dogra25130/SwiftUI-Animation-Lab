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
            .padding(16)
        }
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(hex: "070D15"))
        }
    }
}
