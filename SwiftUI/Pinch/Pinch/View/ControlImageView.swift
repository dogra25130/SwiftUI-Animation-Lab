//
//  ControlImageView.swift
//  Pinch
//
//  Created by Abhishek Dogra on 02/06/23.
//

import SwiftUI

struct ControlImageView: View {
    var icon: String
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 36))
    }
}

struct ControlImageView_Previews: PreviewProvider {
    static var previews: some View {
        ControlImageView(icon: "minus.magnifyingglass")
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
