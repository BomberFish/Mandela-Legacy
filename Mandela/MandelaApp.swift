//
//  MandelaApp.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-12.
//

import SwiftUI

var message = ""
var currentSymbol = ""
var unsandboxed = false

@main
struct MandelaApp: App {
    // Trigger respring
    @State var triggerRespring = false
    var body: some Scene {
        WindowGroup {
            // Pass triggerRespring to ContentView
            ContentView(triggerRespring: $triggerRespring)
                .onAppear{
                    unsandbox()
                }
                // Cool looking respring effect stolen from ballpa1n
                .scaleEffect(triggerRespring ? 0.95 : 1)
                .brightness(triggerRespring ? -1 : 0)
                .preferredColorScheme(.dark)
                .statusBarHidden(triggerRespring)
                // MARK: - Restarts springboard
                .onChange(of: triggerRespring) { _ in
                    if triggerRespring == true {
                        // MARK: - Respring logic
                        let processes = [
                                    "com.apple.cfprefsd.daemon",
                                    "com.apple.backboard.TouchDeliveryPolicyServer"
                                ]
                                for process in processes {
                                    xpc_crash(process)
                                }
                        // old shit respring method
//                        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
//                            guard let window = UIApplication.shared.windows.first else { return }
//                            while true {
//                                window.snapshotView(afterScreenUpdates: false)
//                            }
//                        }
                    }
                }
        }
    }
    func unsandbox() {
        // thanks sourcelocation :trollface:
                   do {
                       // TrollStore method
                       try FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: "/var/mobile"), includingPropertiesForKeys: nil)
                   } catch {
                       // MDC method
                       grant_full_disk_access() { error in
                           if (error != nil) {
                               print("Unsandboxing failed.")
                               unsandboxed = false
                           }
                       }
            }
    }
}
