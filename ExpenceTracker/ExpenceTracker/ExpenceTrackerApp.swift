//
//  ExpenceTrackerApp.swift
//  ExpenceTracker
//
//  Created by Abhishek Dogra on 03/09/23.
//

import SwiftUI

@main
struct ExpenceTrackerApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
