//
//  TypeView.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-14.
//

import SwiftUI

struct TypeView: View {
    @State private var updatedMessage = message
    let mobilegestalt = "/var/containers/Shared/SystemGroup/systemgroup.com.apple.mobilegestaltcache/Library/Caches/com.apple.MobileGestalt.plist"
    var body: some View {
        if #available(iOS 16, *) {
            Button{
                plistChangeInt(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 2796)
            }
        label: {
            Image("iphone.gen3").resizable().frame(width: 13, height: 16)
                .tint(.accentColor)
                .colorMultiply(.accentColor)
                .foregroundColor(.accentColor)
            Text("iPhone 14 Pro Max")
        }
        .controlSize(.large)
        .tint(.accentColor)
        .buttonStyle(.bordered)
            
            Button{
                plistChangeInt(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 2796)
            }
        label: {
            Image("iphone.gen3").resizable().frame(width: 13, height: 16)
                .tint(.accentColor)
                .colorMultiply(.accentColor)
                .foregroundColor(.accentColor)
            Text("iPhone 14 Pro")
        }
        .controlSize(.large)
        .tint(.accentColor)
        .buttonStyle(.bordered)
        }
        Button{
            plistChangeInt(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 2532)
        }
        label: {
            Image("iphone.gen2").resizable().frame(width: 13, height: 16)
                .tint(.accentColor)
                .colorMultiply(.accentColor)
                .foregroundColor(.accentColor)
            Text("iPhone 12/13 Pro")
        }
        .controlSize(.large)
        .tint(.accentColor)
        .buttonStyle(.bordered)
            
            Button{
                plistChangeInt(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 1792)
            }
        label: {
            Image("iphone.gen2").resizable().frame(width: 13, height: 16)
                .tint(.accentColor)
                .colorMultiply(.accentColor)
                .foregroundColor(.accentColor)
            Text("iPhone XR/11")
        }
        .controlSize(.large)
        .tint(.accentColor)
        .buttonStyle(.bordered)
            
            Button{
                plistChangeInt(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 2436)
            }
        label: {
            Image("iphone.gen2").resizable().frame(width: 13, height: 16)
                .tint(.accentColor)
                .colorMultiply(.accentColor)
                .foregroundColor(.accentColor)
            Text("iPhone X/XS/11 Pro")
        }
        .controlSize(.large)
        .tint(.accentColor)
        .buttonStyle(.bordered)
            
            Button{
                plistChangeInt(plistPath: mobilegestalt, key: "ArtworkDeviceSubType", value: 570)
            }
        label: {
            Image("iphone.gen1").resizable().frame(width: 13, height: 16)
                .tint(.accentColor)
                .colorMultiply(.accentColor)
                .foregroundColor(.accentColor)
            Text("iPhone 8")
        }
        .controlSize(.large)
        .tint(.accentColor)
        .buttonStyle(.bordered)
        Text(message)
            .font(.system(size: 14))
            .frame (maxWidth: .infinity, alignment: .center)
            .padding()
            .foregroundColor(Color(UIColor.systemGray))
            
            
        .navigationTitle("Device Type")
        }
    }

struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        TypeView()
    }
}
