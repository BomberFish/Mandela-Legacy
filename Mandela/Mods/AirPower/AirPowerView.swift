//
//  AirPowerView.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-20.
//

import SwiftUI

struct AirPowerView: View {
    @State private var updatedMessage = message
    var body: some View {
        VStack {
            Button("Replace the Charging Sound!", action: OverwriteCharger)
                .controlSize(.large)
                .tint(.accentColor)
                .buttonStyle(.bordered)
            Text(message)
                .font(.system(size: 14))
                .frame (maxWidth: .infinity, alignment: .center)
                .padding()
                .foregroundColor(Color(UIColor.systemGray))
        }
            .navigationTitle("AirPower Sound")
    }
}

struct AirPowerView_Previews: PreviewProvider {
    static var previews: some View {
        AirPowerView()
    }
}
