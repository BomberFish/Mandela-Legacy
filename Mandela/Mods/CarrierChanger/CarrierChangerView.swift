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
            .controlSize(.large)
            .tint(.accentColor)
            .buttonStyle(.bordered)
            Text("WARNING: Whether this tweak works is currently UNKNOWN. Here be dragons.")
                .font(.system(size: 16))
                .frame (maxWidth: .infinity, alignment: .center)
                .padding()
            VStack {
                Image(systemName: currentSymbol)
                    .foregroundColor(Color(UIColor.systemGray))
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

// MARK: - Prompt user for Name
    
func NamePrompt() {
    let alert = UIAlertController(title: "Custom carrier", message: "Enter what to use as the carrier.", preferredStyle: .alert)
    alert.addTextField(configurationHandler: { textField in
        // Narcissism 101
        textField.placeholder = "BomberFish Industries"
    })
    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
        let text = alert.textFields![0].text!
        SetName(newName: text)
    }))
}

struct CarrierChangerView_Previews: PreviewProvider {
    static var previews: some View {
        CarrierChangerView()
    }
}
