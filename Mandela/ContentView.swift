//
//  ContentView.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-12.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        List {
            NavigationLink(destination: Mandela.TypeView()) {
                HStack {
                    // iPhone 14 icon
                    Image("iphone.gen3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16)
                        .tint(Color(UIColor.label))
                    Text("Device Type")
                }
            }
            
            // Any OS
            NavigationLink(destination: Mandela.DOOMView()) {
                HStack {
                    // Controller Icon
                    Image(systemName: "gamecontroller")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32)
                    Text("Replace Licence with DOOM")
                }
            }
            
            NavigationLink(destination: Mandela.AirPowerView()) {
                HStack {
                    // Waves Icon
                    Image(systemName: "dot.radiowaves.left.and.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32)
                    Text("AirPower Charging Sound")
                }
            }
            
            NavigationLink(destination: Mandela.CarrierChangerView()) {
                HStack {
                    // Cellular Icon
                    Image(systemName: "cellularbars")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32)
                    Text("Change Carrier Name")
                }
            }
        }
        // Sidebar
        .listStyle(SidebarListStyle())
        // Mandela
        .navigationTitle("Mandela")
    }
}

struct ContentView: View {
    @Binding var triggerRespring: Bool
    @State private var showInfo = false;
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    var body: some View {
        NavigationView {
            ListView()
                // Top bar
                .toolbar {
                    //Info button
                    Button(action: { showInfo = true }) {
                        Image(systemName: "info.circle")
                    }
                    .alert(isPresented: $showInfo) {
                        Alert(
                            title: Text("Mandela " + appVersion),
                            message: Text("Developed by BomberFish. Tweaks may damage your device, use this app at your own risk.")
                        )
                    }
                    // Respring button
                    Button{
                        respring()
                    }
                    label: {
                        Image(systemName: "arrow.counterclockwise.circle")
                        Text("Respring")
                    }
                }
        }
    }
    
    // Respring function (See MandelaApp.swift)
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
