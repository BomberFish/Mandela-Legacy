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
        if #available(iOS 16, *) {
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
        //.onAppear {
        //let alert = UIAlertController(title: "Warning", message: "This tweak has a chance of damaging your device. By using this tweak, you agree that I (BomberFish) am not responsible for any damage that happens to your device as a result of using this tweak.", preferredStyle: .alert)
        //alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        //UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
        //}
            
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
                plistChange(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 2532)
            }
        label: {
            Text("iPhone 12/13 Pro").font(.system(size: 25))
            Image("iphone.gen2").resizable().frame(width: 25, height: 29)
                .tint(Color(UIColor.label))
        }
        .controlSize(.large)
        .tint(.blue)
        .buttonStyle(.bordered)
            
            Button{
                plistChange(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 1792)
            }
        label: {
            Text("iPhone XR/11").font(.system(size: 25))
            Image("iphone.gen2").resizable().frame(width: 25, height: 29)
                .tint(Color(UIColor.label))
        }
        .controlSize(.large)
        .tint(.blue)
        .buttonStyle(.bordered)
            
            Button{
                plistChange(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 2436)
            }
        label: {
            Text("iPhone X/XS/11 Pro").font(.system(size: 25))
            Image("iphone.gen2").resizable().frame(width: 25, height: 29)
                .tint(Color(UIColor.label))
        }
        .controlSize(.large)
        .tint(.blue)
        .buttonStyle(.bordered)
            
            Button{
                plistChange(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 570)
            }
        label: {
            Text("iPhone 8").font(.system(size: 25))
            Image("iphone.gen1").resizable().frame(width: 25, height: 29)
                .tint(Color(UIColor.label))
        }
        .controlSize(.large)
        .tint(.blue)
        .buttonStyle(.bordered)
            
            
        .navigationTitle("Device Type")
        }
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

struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        TypeView()
    }
}
