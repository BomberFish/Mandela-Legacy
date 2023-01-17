//
//  DOOMView.swift
//  TrollMods
//
//  Created by Hariz Shirazi on 2023-01-08.
//

import SwiftUI

struct DOOMView: View {
    // For alert
    @State private var showInfo = false;
    var body: some View {
        VStack {
            Button("Replace the iOS Licence page! (English)", action: OverwriteLicence)
                .controlSize(.large)
                .tint(.red)
                .buttonStyle(.bordered)
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
