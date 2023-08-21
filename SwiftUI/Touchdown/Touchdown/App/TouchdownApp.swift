//
//  TouchdownApp.swift
//  Touchdown
//
//  Created by Abhishek Dogra on 07/06/23.
//

import SwiftUI

@main
struct TouchdownApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Shop())
        }
    }
}
