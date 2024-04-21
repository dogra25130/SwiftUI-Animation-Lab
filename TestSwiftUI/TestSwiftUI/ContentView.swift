//
//  ContentView.swift
//  TestSwiftUI
//
//  Created by Abhishek Dogra on 25/03/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm: ViewModel = ViewModel()
    var body: some View {
        VStack {
            ForEach(vm.data, id: \.self) { data in
                Text(data.title)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct ViewModelData: Hashable {
    let id = UUID().uuidString
    let title: String
}
class ViewModel: ObservableObject {
    @Published var data: [ViewModelData] = []

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            DispatchQueue.main.async {
                self.data = [ViewModelData(title: "AS")]
//            }
        }
    }
}

