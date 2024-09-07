//
//  PCastAppIntents.swift
//  PCast
//
//  Created by Abhishek Dogra on 01/09/24.
//

import AppIntents

struct PlayTrendingPodcast: AppIntent {
    static let title: LocalizedStringResource = "Play Trending"
    static let openAppWhenRun: Bool = true
    
    @MainActor
    func perform() async throws -> some IntentResult {
        DeeplinkManager.shared.navigateTo(.podcast(PodCastModel(id: "",
                                                                title: "",
                                                                date: "",
                                                                duration: "",
                                                                authorName: "",
                                                                image: "",
                                                                size: "",
                                                                url: "")))
        return .result()
    }
    
}

struct PCastShortcutsProvider: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: PlayTrendingPodcast(),
            phrases: ["Play Trending Podcast on \(.applicationName)"],
            shortTitle: "Play Trending",
            systemImageName: "music.quarternote.3"
        )
    }
}
