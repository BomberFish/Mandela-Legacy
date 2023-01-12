//
//  IslandView.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-12.
//

import SwiftUI

struct IslandView: View {
    let mobilegestalt= "/var/containers/Shared/SystemGroup/systemgroup.com.apple.mobilegestaltcache/Library/Caches/com.apple.MobileGestalt.plist"
    let screenY = Int(UIScreen.main.nativeBounds.height)
    var body: some View {
        Button(
            action: plistChange(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 2796),
        label: {
            Text("Enable")
            Image(Image(systemName: "iphone.gen3"))
                .padding()
                .foregroundColor(Color(UIColor.systemBlue))
                .foregroundColor(Color.white)
                .cornerRadius(10)
        })
        Button(
            action: plistChange(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: screenY),
        label: {
            Text("Disable")
            Image(Image(systemName: "iphone.gen2"))
                .padding()
                .foregroundColor(Color(UIColor.systemRed))
                .foregroundColor(Color.white)
                .cornerRadius(10)
        })
        .navigationTitle("Dynamic Island")
    }
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

struct IslandView_Previews: PreviewProvider {
    static var previews: some View {
        IslandView()
    }
}