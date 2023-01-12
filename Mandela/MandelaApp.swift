//
//  MandelaApp.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-12.
//

import SwiftUI

@main
struct MandelaApp: App {
    @State var triggerRespring = false
    var body: some Scene {
        WindowGroup {
            ContentView(triggerRespring: $triggerRespring)
                .scaleEffect(triggerRespring ? 0.95 : 1)
                .brightness(triggerRespring ? -1 : 0)
                .statusBarHidden(triggerRespring)
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
