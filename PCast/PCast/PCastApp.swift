//
//  PCastAppView.swift
//  PCast
//
//  Created by Abhishek Dogra on 15/08/24.
//

import SwiftUI

@main
struct PCastApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            PCastAppView()
                .onChange(of: scenePhase) { oldValue, newValue in
                    switch newValue {
                    case .active:
                        print("Active")
                    case .background:
                        print("Background")
                    case .inactive:
                        print("Inactive")
                    default:
                        break
                    }
                }
        }
        
    }
}
extension PCastApp {
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                DispatchQueue.main.async {
                    if granted {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
            return true
        }
        
        func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            //        let tokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
            let token = deviceToken.map { String($0) }.joined()
            print(token)
        }
        
        func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: any Error) {
            print(error.localizedDescription)
        }
    }
}
