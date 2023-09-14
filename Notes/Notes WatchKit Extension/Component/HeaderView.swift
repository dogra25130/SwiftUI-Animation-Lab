//
//  Created by Robert Petras
//  Credo Academy ♥ Design and Code
//  https://credo.academy 
//

import SwiftUI

struct HeaderView: View {
  // MARK: - PROPERTY
  
  var title: String = ""

  // MARK: - BODY

  var body: some View {
    VStack {
      // TITLE
      if title != "" {
        Text(title.uppercased())
          .font(.title3)
          .fontWeight(.bold)
          .foregroundColor(.accentColor)
      }
      
      // SEPARATOR
      HStack {
        Capsule()
          .frame(height: 1)
        
        Image(systemName: "note.text")
        
        Capsule()
          .frame(height: 1)
      } //: HSTACK
      .foregroundColor(.accentColor)
    } //: VSTACK
  }
}

// MARK: - PREVIEW

struct HeaderView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      HeaderView(title: "Credits")
      
      HeaderView()
    }
  }
}
