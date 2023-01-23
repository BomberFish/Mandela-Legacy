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
            Button("Change the Carrier Name!", action: NamePrompt())
                .controlSize(.large)
                .tint(.accentColor)
                .buttonStyle(.bordered)
            Text("WARNING: This tweak is currently BROKEN. Use at your own risk")
                .font(.system(size: 16, design: .monospaced))
                .frame (maxWidth: .infinity, alignment: .center)
                .padding()
        }
        .navigationTitle("Change Carrier Name")
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
}
struct CarrierChangerView_Previews: PreviewProvider {
    static var previews: some View {
        CarrierChangerView()
    }
}
