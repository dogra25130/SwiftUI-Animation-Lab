//
//  DeeplinkManager.swift
//  SwiftUINavigation
//
//  Created by Abhishek Dogra on 27/01/24.
//

import SwiftUI

enum Deeplink {
    case secondScreen
}

extension Deeplink: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs: Deeplink, rhs: Deeplink) -> Bool {
        switch (lhs, rhs) {
        case (.secondScreen, .secondScreen):
            return true
        }
    }
}

extension Deeplink: View {
    var body: some View {
        switch self {
        case .secondScreen:
            SecondHomeView()
        }
    }
}

class DeeplinkRouter: BaseRouter {
    func push(to screen: Deeplink) {
        super.navigate(to: screen)
    }
}
