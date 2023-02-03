//
//  ContentView.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-12.
//

import SwiftUI

// MARK: - Main content view

struct ContentView: View {
    @Binding var triggerRespring: Bool
    @State private var showInfo = false
    @State private var updatedMessage = message

    // MARK: - Menu Item classes

    /// Not stolen from Cowabunga
    struct UtilityOption: Identifiable {
        var id = UUID()
        var key: String
        var view: AnyView
        var title: String
        var symbol: String
        var active: Bool = false
    }

    struct FunOption: Identifiable {
        var id = UUID()
        var key: String
        var view: AnyView
        var title: String
        var symbol: String
        var active: Bool = false
    }

    // spicy
    struct DangerousOption: Identifiable {
        var id = UUID()
        var key: String
        var view: AnyView
        var title: String
        var symbol: String
        var active: Bool = false
    }

    struct Category: Identifiable {
        var id = UUID()
        var key: String
        var title: String
        var symbol: String
        var _struct: String
    }

    // MARK: - Items

    @State var UtilityOptions: [UtilityOption] = [
        .init(key: "CarrierName", view: AnyView(CarrierChangerView()), title: "Change Carrier Name", symbol: "antenna.radiowaves.left.and.right"),
        .init(key: "Supervise", view: AnyView(SuperviseView()), title: "Supervise", symbol: "lock.iphone"),
        .init(key: "Mute", view: AnyView(MuteView()), title: "Mute Switch in CC", symbol: "bell.slash"),
    ]
    @State var FunOptions: [FunOption] = [
        .init(key: "DOOM", view: AnyView(DOOMView()), title: "Replace Licence with DOOM", symbol: "doc.append"),
        .init(key: "AirPower", view: AnyView(AirPowerView()), title: "AirPower Charging Sound", symbol: "bolt.fill"),
    ]

    @State var DangerousOptions: [DangerousOption] = [
        .init(key: "Resolution", view: AnyView(ResolutionView()), title: "Change Resolution", symbol: "ruler"),
    ]

    let appVersion = ((Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown") + " (" + (Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown") + ")")
    
    var body: some View {
        NavigationView {
            List {
                Section {
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
                    ForEach($UtilityOptions) { option in
                        NavigationLink(destination: option.view.wrappedValue, isActive: option.active) {
                            HStack {
                                Image(systemName: option.symbol.wrappedValue)
                                    .tint(.accentColor)
                                    .foregroundColor(.accentColor)
                                Text(option.title.wrappedValue)
                            }
                        }
                    }
                } header: {
                    Text("Utility")
                }

                Section {
                    ForEach($FunOptions) { option in
                        NavigationLink(destination: option.view.wrappedValue, isActive: option.active) {
                            HStack {
                                Image(systemName: option.symbol.wrappedValue)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.blue)
                                Text(option.title.wrappedValue)
                                    .padding(.horizontal, 8)
                            }
                        }
                    }
                } header: {
                    Text("Fun")
                }

                Section {
                    ForEach($DangerousOptions) { option in
                        NavigationLink(destination: option.view.wrappedValue, isActive: option.active) {
                            HStack {
                                Image(systemName: option.symbol.wrappedValue)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.blue)
                                Text(option.title.wrappedValue)
                                    .padding(.horizontal, 8)
                            }
                        }
                    }
                } header: {
                    Text("Danger Zone - Handle with Care")
                }

                Section(header: Text("Mandela " + appVersion + "\nMade with ❤️ by BomberFish")) {}

                    // Sidebar
                    .listStyle(SidebarListStyle())
                    // Mandela
                    .navigationTitle("Mandela")
                    // Toolbar
                    .toolbar {
                        // Respring button
                        Button(action: { respring() }) {
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
