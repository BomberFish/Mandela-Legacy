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
                .onAppear {
                    if #available(iOS 16.2, *) {
#if targetEnvironment(simulator)
#else
                        // I'm sorry 16.2 dev beta 1 users, you are a vast minority.
                        print("Throwing not supported error (patched)")
                        UIApplication.shared.alert(title: "Not Supported", body: "This version of iOS is not supported.", withButton: false)
#endif
                    } else {
                        do {
                            // TrollStore method
                            print("Checking if installed with TrollStore...")
                            try FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: "/var/mobile/Library/Caches"), includingPropertiesForKeys: nil)
                        } catch {
                            // MDC method
                            // grant r/w access
                            if #available(iOS 15, *) {
                                print("Trying sandbox escape...")
                                grant_full_disk_access() { error in
                                    if (error != nil) {
                                        print("Unable to escape sandbox! Error: ", String(describing: error?.localizedDescription ?? "unknown?!"))
                                        UIApplication.shared.alert(title: "Access Error", body: "Error: \(String(describing: error?.localizedDescription))\nPlease close the app and retry.", withButton: false)
                                    }
                                }
                            } else {
                                print("Throwing not supported error (too old)")
                                UIApplication.shared.alert(title: "Exploit Not Supported", body: "Please install via TrollStore")
                            }
                        }
                    }
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
