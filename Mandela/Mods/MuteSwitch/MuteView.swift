//
//  MuteView.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-26.
//

import SwiftUI

struct MuteView: View {
    @State private var updatedMessage = message
    var body: some View {
        VStack {
            Button{
                EnableMute()
            }
            label: {
                Image(systemName: "bell.fill")
                    .tint(.accentColor)
                    .foregroundColor(.accentColor)
                Text("Enable")
            }
            .controlSize(.large)
            .tint(.accentColor)
            .buttonStyle(.bordered)
            
            Button{
                DisableMute()
            }
            label: {
                Image(systemName: "bell.slash.fill")
                    .tint(.accentColor)
                    .foregroundColor(.accentColor)
                Text("Disable")
            }
            .controlSize(.large)
            .tint(.accentColor)
            .buttonStyle(.bordered)
            HStack {
                Image(systemName: currentSymbol)
                    .tint(Color(UIColor.systemGray))
                Text(message)
                    .font(.system(size: 14))
                    .frame (maxWidth: .infinity, alignment: .center)
                    .padding()
                    .foregroundColor(Color(UIColor.systemGray))
            }
        }
            .navigationTitle("Mute toggle")
    }
}

struct MuteView_Previews: PreviewProvider {
    static var previews: some View {
        MuteView()
    }
}
