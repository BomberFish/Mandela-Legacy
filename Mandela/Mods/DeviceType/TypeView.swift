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
                plistChangeInt(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 2796)
            }
        label: {
            Text("iPhone 14 Pro Max")
            Image("iphone.gen3").resizable().frame(width: 13, height: 16)
                .tint(.accentColor)
                .colorMultiply(.accentColor)
                .foregroundColor(.accentColor)
        }
        .controlSize(.large)
        .tint(.accentColor)
        .buttonStyle(.bordered)
            //.onAppear {
            //let alert = UIAlertController(title: "Warning", message: "This tweak has a chance of damaging your device. By using this tweak, you agree that I (BomberFish) am not responsible for any damage that happens to your device as a result of using this tweak.", preferredStyle: .alert)
            //alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
            //UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
            //}
            
            Button{
                plistChangeInt(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 2796)
            }
        label: {
            Text("iPhone 14 Pro")
            Image("iphone.gen3").resizable().frame(width: 13, height: 16)
                .tint(.accentColor)
                .colorMultiply(.accentColor)
                .foregroundColor(.accentColor)
        }
        .controlSize(.large)
        .tint(.accentColor)
        .buttonStyle(.bordered)
        }
        Button{
            plistChangeInt(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 2532)
        }
        label: {
            Text("iPhone 12/13 Pro")
            Image("iphone.gen2").resizable().frame(width: 13, height: 16)
                .tint(.accentColor)
                .colorMultiply(.accentColor)
                .foregroundColor(.accentColor)
        }
        .controlSize(.large)
        .tint(.accentColor)
        .buttonStyle(.bordered)
            
            Button{
                plistChangeInt(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 1792)
            }
        label: {
            Text("iPhone XR/11")
            Image("iphone.gen2").resizable().frame(width: 13, height: 16)
                .tint(.accentColor)
                .colorMultiply(.accentColor)
                .foregroundColor(.accentColor)
        }
        .controlSize(.large)
        .tint(.accentColor)
        .buttonStyle(.bordered)
            
            Button{
                plistChangeInt(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 2436)
            }
        label: {
            Text("iPhone X/XS/11 Pro")
            Image("iphone.gen2").resizable().frame(width: 13, height: 16)
                .tint(.accentColor)
                .colorMultiply(.accentColor)
                .foregroundColor(.accentColor)
        }
        .controlSize(.large)
        .tint(.accentColor)
        .buttonStyle(.bordered)
            
            Button{
                plistChangeInt(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 570)
            }
        label: {
            Text("iPhone 8")
            Image("iphone.gen1").resizable().frame(width: 13, height: 16)
                .tint(.accentColor)
                .colorMultiply(.accentColor)
                .foregroundColor(.accentColor)
        }
        .controlSize(.large)
        .tint(.accentColor)
        .buttonStyle(.bordered)
            
            
        .navigationTitle("Device Type")
        }
    }

struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        TypeView()
    }
}
