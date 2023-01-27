//
//  CarrierChangerView.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-20.
//

import SwiftUI

struct CarrierChangerView: View {
    @State private var updatedMessage = message
    var body: some View {
        VStack {
            Button{
                impactVibrate()
                NamePrompt()
            }
            label: {
                Image(systemName: "antenna.radiowaves.left.and.right")
                    .tint(.accentColor)
                    .foregroundColor(.accentColor)
                Text("Enable")
            }
            Text("WARNING: Whether this tweak works is currently UNKNOWN. Here be dragons.")
                .font(.system(size: 16))
                .frame (maxWidth: .infinity, alignment: .center)
                .padding()
            HStack {
                Image(systemName: currentSymbol)
                    .tint(Color(UIColor.systemGray))
                Text(message)
                    .font(.system(size: 14))
                    .frame (maxWidth: .infinity, alignment: .center)
                    .padding()
                    .foregroundColor(Color(UIColor.systemGray))
            }
        }
        .navigationTitle("Change Carrier Name")
    }
}

struct CarrierChangerView_Previews: PreviewProvider {
    static var previews: some View {
        CarrierChangerView()
    }
}
