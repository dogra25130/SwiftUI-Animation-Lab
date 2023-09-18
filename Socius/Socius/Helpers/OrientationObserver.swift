//
//  OrientationObserver.swift
//  Socius
//
//  Created by Abhishek Dogra on 17/09/23.
//
import Foundation
import SwiftUI

class OrientationObserver: ObservableObject {
    @Published var deviceOrientation = UIDevice.current.orientation

    init() {
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    deinit {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func orientationDidChange() {
        deviceOrientation = UIDevice.current.orientation
    }
}

