//
//  CarrierChangerView.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-20.
//

import SwiftUI

struct CarrierChangerView: View {
    var body: some View {
        VStack {
            Button("Change the Carrier Name!", action: NamePrompt)
                .controlSize(.large)
                .tint(.accentColor)
                .buttonStyle(.bordered)
            Text("WARNING: Whether this tweak works is currently UNKNOWN. Here be dragons.")
                .font(.system(size: 16, design: .monospaced))
                .frame (maxWidth: .infinity, alignment: .center)
                .padding()
        }
        .navigationTitle("Change Carrier Name")
    }
}

struct CarrierChangerView_Previews: PreviewProvider {
    static var previews: some View {
        CarrierChangerView()
    }
}
