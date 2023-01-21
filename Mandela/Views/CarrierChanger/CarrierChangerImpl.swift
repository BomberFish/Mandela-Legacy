//
//  CarrierChangerImpl.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-20.
//

import Foundation

// MARK: - Set Carrier Name
func SetName(newName: String) {
    var succeededOnce: Bool = false
    // FIXME: This is utterly broken last time I checked
    // Credit: TrollTools for process
    // get the carrier files
    for url in try! FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: "/var/mobile/Library/Carrier Bundles/Overlay/"), includingPropertiesForKeys: nil) {
        guard let plistData = try? Data(contentsOf: url) else { continue }
        guard var plist = try? PropertyListSerialization.propertyList(from: plistData, format: nil) as? [String:Any] else { continue }
        let originalSize = plistData.count
        // modify values
        print("Modifying: " + (plist["CarrierName"] as! String))
        if var images = plist["StatusBarImages"] as? [[String: Any]] {
            for var (i, image) in images.enumerated() {
                image["StatusBarCarrierName"] = newName
                    
                images[i] = image
            }
            plist["StatusBarImages"] = images
        }
            
            // remove unnecessary parameters
            plist.removeValue(forKey: "CarrierName")
            plist.removeValue(forKey: "CarrierBookmarks")
            plist.removeValue(forKey: "StockSymboli")
            plist.removeValue(forKey: "MyAccountURL")
            //plist.removeValue(forKey: "HomeBundleIdentifier")
            plist.removeValue(forKey: "MyAccountURLTitle")
            
            // create the new data
            guard var newData = try? PropertyListSerialization.data(fromPropertyList: plist, format: .binary, options: 0) else { continue }
            
            // add data if too small
            // while loop to make data match because recursive function didn't work
            // very slow, will hopefully improve
            var newDataSize = newData.count
            var added = 1
            while newDataSize < originalSize {
                plist.updateValue(String(repeating: "#", count: added), forKey: "MyAccountURLTitle")
                added += 1
                //plist["MyAccountURLTitle"] = plist["MyAccountURLTitle"] as! String + "#"
                newData = try! PropertyListSerialization.data(fromPropertyList: plist, format: .binary, options: 0)
                newDataSize = newData.count
            }
            // apply
            overwriteFile(newData, url.path)
        }
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
