//
//  LogoView.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/08/24.
//

import SwiftUI
struct LogoView: View {
    var logoSize = CGSize(width: 78, height: 78)
    var fontStyle: Font = .setFont(.semiBold600, 32)
    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .frame(width: logoSize.width, height: logoSize.height)
            
            Text("pcast")
                .font(fontStyle)
            
            Spacer()
        }
    }
}
