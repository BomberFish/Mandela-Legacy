//
//  SuperviseView.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-26.
//

import SwiftUI

struct SuperviseView: View {
    @State private var updatedMessage = message
    var body: some View {
        VStack {
            Button{
                impactVibrate()
                Supervise()
            }
            label: {
                Image(systemName: "lock.iphone")
                    .tint(.accentColor)
                    .foregroundColor(.accentColor)
                Text("Supervise")
            }
            .controlSize(.large)
            .tint(.accentColor)
            .buttonStyle(.bordered)
            
            Button{
                impactVibrate()
                Unsupervise()
            }
            label: {
                Image(systemName: "lock.open.iphone")
                    .tint(.accentColor)
                    .foregroundColor(.accentColor)
                Text("Unsupervise")
            }
            .controlSize(.large)
            .tint(.accentColor)
            .buttonStyle(.bordered)
            VStack {
                Image(systemName: currentSymbol)
                    .foregroundColor(Color(UIColor.systemGray))
                Text(message)
                    .font(.system(size: 14))
                    .frame (maxWidth: .infinity, alignment: .center)
                    .padding()
                    .foregroundColor(Color(UIColor.systemGray))
            }
        }
            .navigationTitle("Supervise")
    }
}

struct SuperviseView_Previews: PreviewProvider {
    static var previews: some View {
        SuperviseView()
    }
}
