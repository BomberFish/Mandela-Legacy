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
    
    // MARK:- Prompt user for Name
    
    func NamePrompt() {
        let alert = UIAlertController(title: "Custom carrier", message: "Enter a string to use as the custom carrier.", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "pwned."
        })
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            let text = alert.textFields![0].text!
            if text.count == 6 {
                // FIXME: Use the plistChange function
                // (this will not compile otherwise)
                stringsChange(stringsPath: "/System/Library/PrivateFrameworks/SystemStatusServer.framework/en_GB.lproj/SystemStatusServer-Telephony.strings", key: "NO_SIM", value: text)
            } else {
                let alert = UIAlertController(title: "Invalid string", message: "The string must be 6 characters long.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }))
    }
    
    // MARK:- plist editing function
    
    func plistChange(plistPath: String, key: String, value: Int) {
        let stringsData = try! Data(contentsOf: URL(fileURLWithPath: plistPath))
        
        let plist = try! PropertyListSerialization.propertyList(from: stringsData, options: [], format: nil) as! [String: Any]
        func changeValue(_ dict: [String: Any], _ key: String, _ value: Int) -> [String: Any] {
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
}

struct CarrierChangerView_Previews: PreviewProvider {
    static var previews: some View {
        CarrierChangerView()
    }
}
