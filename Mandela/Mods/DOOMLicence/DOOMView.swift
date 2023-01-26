//
//  DOOMView.swift
//  TrollMods
//
//  Created by Hariz Shirazi on 2023-01-08.
//

import SwiftUI

struct DOOMView: View {
    @State private var updatedMessage = message
    var body: some View {
        VStack {
            Button{
                OverwriteLicence()
            }
            label: {
                Image(systemName: "doc.append")
                    .tint(.accentColor)
                    .foregroundColor(.accentColor)
                Text("Enable")
            }
            .controlSize(.large)
            .tint(.accentColor)
            .buttonStyle(.bordered)
            Text(message)
                .font(.system(size: 14))
                .frame (maxWidth: .infinity, alignment: .center)
                .padding()
                .foregroundColor(Color(UIColor.systemGray))
        }
        Text("DOOM is property of id Software and ZeniMax Media. All rights reserved.")
            .foregroundColor(Color(UIColor.tertiarySystemBackground))
            .font(.system(size: 12, design: .monospaced))
            .frame (maxWidth: .infinity, alignment: .center)
            .padding()
            
            .navigationTitle("DOOM Licence")
    }
}

struct DOOMView_Previews: PreviewProvider {
    static var previews: some View {
        DOOMView()
    }
}
