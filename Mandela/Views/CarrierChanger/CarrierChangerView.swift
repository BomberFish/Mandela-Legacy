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
            Button("Change the Carrier Name!", action: OverwriteCharger)
                .controlSize(.large)
                .tint(.green)
                .buttonStyle(.bordered)
        }
        .navigationTitle("Change Carrier Name")
    }
    
    // MARK: - Prompt user for Name
    
    func NamePrompt() {
        let alert = UIAlertController(title: "Custom carrier", message: "Enter what to use as the carrier.", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
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
