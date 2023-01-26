//
//  DOOMImpl.swift
//  TrollMods
//
//  Created by Hariz Shirazi on 2023-01-08.
//

import Foundation


func OverwriteLicence() {
    DispatchQueue.global(qos: .userInteractive).async {
        let locale = (NSLocale.system as NSLocale).object(forKey: .countryCode) as! String
        let path = "/System/Library/ProductDocuments/SoftwareLicenseAgreements/iOS.bundle/" + locale + ".lproj/License.html"
        let data = "PCFET0NUWVBFIGh0bWw+CjxodG1sIGxhbmc9ImVuIj4KPGhlYWQ+CiAgPG1ldGEgY2hhcnNldD0iVVRGLTgiPgogIDxtZXRhIGh0dHAtZXF1aXY9IlgtVUEtQ29tcGF0aWJsZSIgY29udGVudD0iSUU9ZWRnZSI+CiAgPG1ldGEgbmFtZT0idmlld3BvcnQiIGNvbnRlbnQ9IndpZHRoPWRldmljZS13aWR0aCwgaW5pdGlhbC1zY2FsZT0xLjAiPgogIDx0aXRsZT5BIDEwMCUgbGVnaXRpbWF0ZSB3YXJyYW50eTwvdGl0bGU+CiAgPHN0eWxlPgogICAgYm9keSB7CiAgICAgIGJhY2tncm91bmQtY29sb3I6IGJsYWNrOwogICAgICBtYXJnaW46IGF1dG87CiAgICAgIHdpZHRoOiA2NDBweDsKICAgIH0KCiAgICBpZnJhbWUgewogICAgICBib3JkZXI6IG5vbmU7CiAgICB9CiAgPC9zdHlsZT4KPC9oZWFkPgo8Ym9keT4KICA8aWZyYW1lIHNyYz0iaHR0cHM6Ly9kb29tLmJvbWJlcmZpc2guY2EiIHRpdGxlPSJXYWl0IHRoaXMgaXNuJ3QgYSB3YXJyYW50eSEiIHdpZHRoPSI2NDAiIGhlaWdodD0iOTYwIj48L2lmcmFtZT4KPC9ib2R5Pgo8L2h0bWw+"
        overwriteFile(try! Data(base64Encoded: data), path);
        // Write to English file just in case
        overwriteFile(try! Data(base64Encoded: data), "/System/Library/ProductDocuments/SoftwareLicenseAgreements/iOS.bundle/en.lproj/License.html");
    }
}

