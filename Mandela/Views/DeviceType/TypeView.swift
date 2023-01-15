//
//  TypeView.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-14.
//

import SwiftUI

struct TypeView: View {
    let mobilegestalt = "/var/containers/Shared/SystemGroup/systemgroup.com.apple.mobilegestaltcache/Library/Caches/com.apple.MobileGestalt.plist"
    var body: some View {
        Button{
            plistChange(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 2796)
        }
        label: {
            Text("iPhone 14 Pro Max").font(.system(size: 25))
            Image("iphone.gen3").resizable().frame(width: 25, height: 29)
                .tint(Color(UIColor.label))
        }
            .controlSize(.large)
            .tint(.blue)
            .buttonStyle(.bordered)
        
        Button{
            plistChange(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 2796)
        }
        label: {
            Text("iPhone 14 Pro").font(.system(size: 25))
            Image("iphone.gen3").resizable().frame(width: 25, height: 29)
                .tint(Color(UIColor.label))
        }
            .controlSize(.large)
            .tint(.blue)
            .buttonStyle(.bordered)
        
        Button{
            plistChange(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 420 ) // Placeholder
        }
        label: {
            Text("Disable").font(.system(size: 25))
            Image("iphone.gen2.slash").resizable().frame(width: 25, height: 29)
                .tint(Color(UIColor.label))
        }
            .controlSize(.large)
            .tint(.red)
            .buttonStyle(.bordered)
        
        
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

        OverwriteFile(newFileData: newData, targetPath: plistPath)
    }
}

struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        TypeView()
    }
}
