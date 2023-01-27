//
//  MandelaApp.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-12.
//

import SwiftUI

var message = ""
var currentSymbol = ""
    
@main
struct MandelaApp: App {
    // Trigger respring
    @State var triggerRespring = false
    var body: some Scene {
        WindowGroup {
            // Pass triggerRespring to ContentView
            ContentView(triggerRespring: $triggerRespring)
                // Cool looking respring effect stolen from ballpa1n
                .scaleEffect(triggerRespring ? 0.95 : 1)
                .brightness(triggerRespring ? -1 : 0)
                .preferredColorScheme(.dark)
                .statusBarHidden(triggerRespring)
                // MARK: - Restarts springboard
                .onChange(of: triggerRespring) { _ in
                    if triggerRespring == true {
                        // MARK: - The main springboard bug
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
