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
            if #available(iOS 16, *) {
                NavigationLink(destination: Mandela.IslandView()) {
                    HStack {
                        Image("iphone.gen3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16)
                            .tint(Color(UIColor.label))
                        Text("Dynamic Island")
                    }
                }
            }
            NavigationLink(destination: Mandela.DOOMView()) {
                HStack {
                    Image(systemName: "gamecontroller")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32)
                    Text("Replace Licence with DOOM")
                }
            }
        }
        .listStyle(SidebarListStyle())
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
    func respring() {
        withAnimation(.easeInOut) {
            triggerRespring = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(triggerRespring: .constant(false))
    }
}
