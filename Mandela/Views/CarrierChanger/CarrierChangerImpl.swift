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
        plistChange(plistPath: url.path, key: "StatusBarCarrierName", value: newName)
    }
}

// MARK: - plist editing function
func plistChange(plistPath: String, key: String, value: String) {
    let stringsData = try! Data(contentsOf: URL(fileURLWithPath: plistPath))
    
    let plist = try! PropertyListSerialization.propertyList(from: stringsData, options: [], format: nil) as! [String: Any]
    func changeValue(_ dict: [String: Any], _ key: String, _ value: String) -> [String: Any] {
        var newDict = dict
        for (k, v) in dict {
            if k == key {
                newDict[k] = value
            } else if let subDict = v as? [String: Any] {
                newDict[k] = changeValue(subDict, key, value)
            }
        }
        return newDict
    }

    var newPlist = plist
    newPlist = changeValue(newPlist, key, value)

    let newData = try! PropertyListSerialization.data(fromPropertyList: newPlist, format: .binary, options: 0)

    overwriteFile(newData, plistPath)
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
