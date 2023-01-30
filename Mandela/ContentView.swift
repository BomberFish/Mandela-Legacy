//
//  ContentView.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-12.
//

import SwiftUI

// MARK: - List
// TODO:
struct ListView: View {
    let systemVersion = UIDevice.current.systemVersion
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
    var body: some View {
        List {
            Section(header: Text("Utility")) {
                NavigationLink(destination: Mandela.TypeView()) {
                    HStack {
                        // iPhone 14 icon
                        Image("iphone.gen3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 12)
                            .tint(.accentColor)
                            .colorMultiply(.accentColor)
                            .foregroundColor(.accentColor)
                        Text("Device Type")
                    }
                }
                NavigationLink(destination: Mandela.CarrierChangerView()) {
                    HStack {
                        // Antenna Icon
                        Image(systemName: "antenna.radiowaves.left.and.right")
                            .tint(.accentColor)
                            .foregroundColor(.accentColor)
                        Text("Change Carrier Name")
                    }
                }
                NavigationLink(destination: Mandela.SuperviseView()) {
                    HStack {
                        // Lock Icon
                        Image(systemName: "lock.iphone")
                            .tint(.accentColor)
                            .foregroundColor(.accentColor)
                        Text("Supervise")
                    }
                }
                NavigationLink(destination: Mandela.MuteView()) {
                    HStack {
                        // Mute Icon
                        Image(systemName: "bell.slash.fill")
                            .tint(.accentColor)
                            .foregroundColor(.accentColor)
                        Text("Mute Switch in Control Center")
                    }
                }
            }
            
            
            Section(header: Text("Fun")) {
                NavigationLink(destination: Mandela.DOOMView()) {
                    HStack {
                        // Document Icon
                        Image(systemName: "doc.append")
                            .tint(.accentColor)
                            .foregroundColor(.accentColor)
                        Text("Replace Licence with DOOM")
                    }
                }
                NavigationLink(destination: Mandela.AirPowerView()) {
                    HStack {
                        // Bolt Icon
                        Image(systemName: "bolt.fill")
                            .tint(.accentColor)
                            .foregroundColor(.accentColor)
                        Text("AirPower Charging Sound")
                    }
                }
            }
            Section(header: Text("Danger Zone")) {

//                NavigationLink(destination: Mandela.VersionView()) {
//                    HStack {
//                        // Gear Icon
//                        Image(systemName: "gear.badge")
//                            .tint(.accentColor)
//                            .foregroundColor(.accentColor)
//                        Text("Software Version")
//                    }
//                }
                NavigationLink(destination: Mandela.ResolutionView()) {
                    HStack {
                        // Ruler Icon
                        Image(systemName: "ruler")
                            .tint(.accentColor)
                            .foregroundColor(.accentColor)
                        Text("Change Resolution")
                    }
                }
            }
            Section(header: Text("Mandela " + appVersion + " (" + appBuild +")" + ", iOS " + systemVersion)) {}
            
        }
        // Sidebar
        .listStyle(SidebarListStyle())
        // Mandela
        .navigationTitle("Mandela")
    }
}

// MARK: - Main content view
struct ContentView: View {
    @Binding var triggerRespring: Bool
    @State private var showInfo = false;
    @State private var updatedMessage = message
    var body: some View {
        VStack {
            NavigationView {
                ListView()
                // Toolbar
                .toolbar {
                    // Respring button
                    Button(action: {respring()}){
                        Image(systemName: "arrow.counterclockwise.circle")
                        Text("Respring")
                    }
                }
            }
        }
    }
    // MARK: - Respring function (See MandelaApp.swift)
    func respring() {
        withAnimation(.easeInOut) {
            triggerRespring = true
        }
    }
}


// :fr:
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(triggerRespring: .constant(false))
    }
}
