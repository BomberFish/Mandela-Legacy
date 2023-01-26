//
//  CarrierChangerImpl.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-20.
//

import Foundation
import SwiftUI

// MARK: - Set Carrier Name
func SetName(newName: String) {
    // TODO: Test if this works
    for url in try! FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: "/var/mobile/Library/Carrier Bundles/Overlay/"), includingPropertiesForKeys: nil) {
        plistChangeStr(plistPath: url.path, key: "StatusBarCarrierName", value: newName)
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
