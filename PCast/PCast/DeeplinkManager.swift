//
//  DeeplinkManager.swift
//  PCast
//
//  Created by Abhishek Dogra on 19/08/24.
//

import SwiftUI

enum Deeplink: Hashable {
    case podcast(PodCastModel)
    case browse
    case Reels
}
