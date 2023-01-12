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
            Text("Hello, world!")
            Text("Hello, world!")
            Text("Hello, world!")
            Text("Hello, world!")
            Text("Hello, world!")
        }
        .navigationTitle("Mandela")
    }
}

struct ContentView: View {
    @Binding var triggerRespring: Bool
    var body: some View {
        ListView()
            .toolbar {
                Button(action: respring()) {
                Image(systemName: "arrow.counterclockwise.circle")
                Text("Respring")
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
