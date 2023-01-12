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
    var body: some View {
        VStack {
            ListView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
