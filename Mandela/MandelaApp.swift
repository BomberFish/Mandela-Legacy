//
//  MandelaApp.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-12.
//

import SwiftUI

@main
struct MandelaApp: App {
    // Trigger respring
    @State var triggerRespring = false
    var body: some Scene {
        WindowGroup {
            // Pass triggerRespring to ContentView
            ContentView(triggerRespring: $triggerRespring)
                // Cool looking effect stolen from the testicular discomfort jailbreak
                .scaleEffect(triggerRespring ? 0.95 : 1)
                .brightness(triggerRespring ? -1 : 0)
                .statusBarHidden(triggerRespring)
                // Restarts springboard
                .onChange(of: triggerRespring) { _ in
                    if triggerRespring == true {
                        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
                            guard let window = UIApplication.shared.windows.first else { return }
                            while true {
                                window.snapshotView(afterScreenUpdates: false)
                            }
                        }
                    }
                }
        }
    }
}
