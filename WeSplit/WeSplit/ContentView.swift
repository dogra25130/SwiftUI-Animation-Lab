
import SwiftUI

struct ContentView: View {
    @State private var animate = false
    @State private var isRotating = 0.0

    var body: some View {
        Grid(horizontalSpacing: 3, verticalSpacing: 15) {
            ForEach(0..<50){ row in
                GridRow {
                    ForEach(0..<25, id: \.self){ col in
                        Rectangle()
                            .frame(width: 15,height: 3)
                            .rotationEffect(Angle(degrees: animate ? -360 : 0))
                            .animation(
                                .linear(duration: 1.5)
                                .repeatForever(autoreverses: false)
                                .delay(Double(row + col) * 0.05)
                                ,value: animate
                            )
                    }
                }
            }
            
        }
        .onAppear{ animate.toggle() }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
