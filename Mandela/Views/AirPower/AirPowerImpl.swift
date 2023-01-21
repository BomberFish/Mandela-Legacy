//
//  AirPowerImpl.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-20.
//

import Foundation


func OverwriteCharger() {
    DispatchQueue.global(qos: .userInteractive).async {
        let htmlfile = Bundle.main.path(forResource: "engage_power", ofType: "m4a");
        // TODO: Get device locale
        /// This should be easy, considering there are public APIs to do this
        /// https://stackoverflow.com/questions/40909754/ddg#40909806
        /// https://developer.apple.com/documentation/foundation/nslocale
        overwriteFile(try? Data(contentsOf: URL.init(fileURLWithPath: htmlfile!)), "/System/Library/Audio/UISounds/connect_power.caf");
    }
}


