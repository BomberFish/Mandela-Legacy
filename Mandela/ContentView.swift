//
//  ContentView.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-12.
//

import SwiftUI

// MARK: - List
struct ListView: View {
    var body: some View {
        List {
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
            
            // Any OS
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
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    var body: some View {
        NavigationView {
            ListView()
                // MARK: - Top bar
                .toolbar {
                    // Respring button
                    Button(action: {respring()}){
                        Image(systemName: "arrow.counterclockwise.circle")
                        Text("Respring")
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
