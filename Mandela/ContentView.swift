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
            NavigationLink(destination: TrollMods.TrollLockView()) {
                HStack {
                    Image(systemName: "iphone.gen3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32)
                        .cornerRadius(8)
                    Text("Dynamic Island")
                }
            }
        }
        .navigationTitle("Mandela")
    }
}

struct MainNav<Content>: View where Content: View {
    @ViewBuilder var content: () -> Content;
    
    var body: some View {
        if #available(iOS 16, *) {
            NavigationStack(root: content)
        } else {
            NavigationView(content: content)
        }
    }
}

struct ContentView: View {
    @Binding var triggerRespring: Bool
    var body: some View {
        MainNav {
            ListView()
            .toolbar {
                Button(action: respring()) {
                    Image(systemName: "arrow.counterclockwise.circle")
                    Text("Respring")
                }
            }
    }
    func respring() {
        withAnimation(.easeInOut) {
            triggerRespring = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
