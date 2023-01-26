//
//  MuteImpl.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-26.
//

import Foundation

func EnableMute() {
    DispatchQueue.global(qos: .userInteractive).async {
        let data = "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4gPCFET0NUWVBFIHBsaXN0IFBVQkxJQyAiLS8vQXBwbGUvL0RURCBQTElTVCAxLjAvL0VOIiAiaHR0cDovL3d3dy5hcHBsZS5jb20vRFREcy9Qcm9wZXJ0eUxpc3QtMS4wLmR0ZCI+IDxwbGlzdCB2ZXJzaW9uPSIxLjAiPiA8ZGljdD4gPGtleT5TQkljb25WaXNpYmlsaXR5PC9rZXk+IDx0cnVlLz4gPC9kaWN0PiA8L3BsaXN0Pgo="
        overwriteFile(try! Data(base64Encoded: data), "/var/Managed Preferences/mobile/com.apple.control-center.MuteModule.plist");
    }
}

func DisableMute() {
    DispatchQueue.global(qos: .userInteractive).async {
        let data = "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPCFET0NUWVBFIHBsaXN0IFBVQkxJQyAiLS8vQXBwbGUvL0RURCBQTElTVCAxLjAvL0VOIiAiaHR0cDovL3d3dy5hcHBsZS5jb20vRFREcy9Qcm9wZXJ0eUxpc3QtMS4wLmR0ZCI+CjxwbGlzdCB2ZXJzaW9uPSIxLjAiPgo8ZGljdD4KCTxrZXk+U0JJY29uVmlzaWJpbGl0eTwva2V5PgoJPGZhbHNlLz4KPC9kaWN0Pgo8L3BsaXN0Pgo="
        overwriteFile(try! Data(base64Encoded: data), "/var/Managed Preferences/mobile/com.apple.control-center.MuteModule.plist");
    }
}

