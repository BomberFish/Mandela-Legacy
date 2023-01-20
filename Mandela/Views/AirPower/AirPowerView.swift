//
//  AirPowerView.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-20.
//

import SwiftUI

struct AirPowerView: View {
    var body: some View {
        VStack {
            Button("Replace the Charging Sound!", action: OverwriteCharger)
                .controlSize(.large)
                .tint(.green)
                .buttonStyle(.bordered)
        }
            .navigationTitle("AirPower Sound")
    }
}

struct AirPowerView_Previews: PreviewProvider {
    static var previews: some View {
        AirPowerView()
    }
}
