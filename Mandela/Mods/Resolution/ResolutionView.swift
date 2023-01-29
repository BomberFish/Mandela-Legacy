//
//  ResolutionView.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-29.
//

import SwiftUI

struct ResolutionView: View {
    @State var width: Double = UIScreen.main.nativeBounds.width
    @State var height: Double = UIScreen.main.nativeBounds.height
    var body: some View {
        VStack {
            TextField("New height", value: $height, format: .number)
                                .textFieldStyle(.roundedBorder)
            TextField("New width", value: $width, format: .number)
                                .textFieldStyle(.roundedBorder)
            Button(action: {
                                setResolution()
                            }) {
                                Text("Set resolution")
                                    .padding()
                            }
                            .controlSize(.large)
                            .tint(.accentColor)
                            .buttonStyle(.bordered)
            // dont close source resset plz thanks uwu
            Text("Thanks sourcelocation for ResSet code")
                .foregroundColor(Color(UIColor.tertiarySystemBackground))
                .font(.system(size: 12, design: .monospaced))
                .frame (maxWidth: .infinity, alignment: .center)
                .padding()
        }
        .navigationTitle("Change Resolution")
    }
    func createPlist(at url: URL) throws {
            let created_plist : [String: Any] = [
                "canvas_height": Int(height),
                "canvas_width": Int(width),
            ]
            let data = NSDictionary(dictionary: created_plist)
            data.write(toFile: url.path, atomically: true)
        }
    func setResolution() {
            do {
                let tmpPlistURL = URL(fileURLWithPath: "/var/tmp/com.apple.iokit.IOMobileGraphicsFamily.plist")
                try? FileManager.default.removeItem(at: tmpPlistURL)
                
                try createPlist(at: tmpPlistURL)
                
                let aliasURL = URL(fileURLWithPath: "/private/var/mobile/Library/Preferences/com.apple.iokit.IOMobileGraphicsFamily.plist")
                try? FileManager.default.removeItem(at: aliasURL)
                try FileManager.default.createSymbolicLink(at: aliasURL, withDestinationURL: tmpPlistURL)
            } catch {
                print("oh no error")
            }
        }
}

struct ResolutionView_Previews: PreviewProvider {
    static var previews: some View {
        ResolutionView()
    }
}
