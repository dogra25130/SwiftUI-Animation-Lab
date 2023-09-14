//
//  Created by Robert Petras
//  Credo Academy ♥ Design and Code
//  https://credo.academy 
//

import SwiftUI

struct SettingsView: View {
  // MARK: - PROPERTY
  
  @AppStorage("lineCount") var lineCount: Int = 1
  @State private var value: Float = 1.0
  
  // MARK: - FUNCTION

  func update() {
    lineCount = Int(value)
  }

  // MARK: - BODY

  var body: some View {
    VStack(spacing: 8) {
      // HEADER
      HeaderView(title: "Settings")
      
      // ACTUAL LINE COUNT
      Text("Lines: \(lineCount)".uppercased())
        .fontWeight(.bold)
      
      // SLIDER
      Slider(value: Binding(get: {
        self.value
      }, set: {(newValue) in
        self.value = newValue
        self.update()
      }), in: 1...4, step: 1)
        .accentColor(.accentColor)
    } //: VSTACK
  }
}

// MARK: - PREVIEW

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
