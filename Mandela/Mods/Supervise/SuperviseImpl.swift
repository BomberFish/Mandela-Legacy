//
//  SuperviseImpl.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-26.
//

import Foundation

func Supervise() {
    DispatchQueue.global(qos: .userInteractive).async {
        let data = "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4gPCFET0NUWVBFIHBsaXN0IFBVQkxJQyAiLS8vQXBwbGUvL0RURCBQTElTVCAxLjAvL0VOIiAiaHR0cDovL3d3dy5hcHBsZS5jb20vRFREcy9Qcm9wZXJ0eUxpc3QtMS4wLmR0ZCI+IDxwbGlzdCB2ZXJzaW9uPSIxLjAiPiA8ZGljdD4gPGtleT5BbGxvd1BhaXJpbmc8L2tleT4gPHRydWUvPiA8a2V5PkNsb3VkQ29uZmlndXJhdGlvblVJQ29tcGxldGU8L2tleT4gPHRydWUvPiA8a2V5PkNvbmZpZ3VyYXRpb25Tb3VyY2U8L2tleT4gPGludGVnZXI+MDwvaW50ZWdlcj4gPGtleT5Jc1N1cGVydmlzZWQ8L2tleT4gPHRydWUvPiA8a2V5PlBvc3RTZXR1cFByb2ZpbGVXYXNJbnN0YWxsZWQ8L2tleT4gPHRydWUvPiA8L2RpY3Q+IDwvcGxpc3Q+"
        overwriteFile(try! Data(base64Encoded: data), "/var/containers/Shared/SystemGroup/systemgroup.com.apple.configurationprofiles/Library/ConfigurationProfiles/CloudConfigurationDetails.plist");
    }
}

func Unsupervise() {
    DispatchQueue.global(qos: .userInteractive).async {
        let data = "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPCFET0NUWVBFIHBsaXN0IFBVQkxJQyAiLS8vQXBwbGUvL0RURCBQTElTVCAxLjAvL0VOIiAiaHR0cDovL3d3dy5hcHBsZS5jb20vRFREcy9Qcm9wZXJ0eUxpc3QtMS4wLmR0ZCI+CjxwbGlzdCB2ZXJzaW9uPSIxLjAiPgo8ZGljdD4KCTxrZXk+QWxsb3dQYWlyaW5nPC9rZXk+Cgk8dHJ1ZS8+Cgk8a2V5PkNsb3VkQ29uZmlndXJhdGlvblVJQ29tcGxldGU8L2tleT4KCTx0cnVlLz4KCTxrZXk+Q29uZmlndXJhdGlvblNvdXJjZTwva2V5PgoJPGludGVnZXI+MDwvaW50ZWdlcj4KCTxrZXk+SXNTdXBlcnZpc2VkPC9rZXk+Cgk8ZmFsc2UvPgoJPGtleT5Qb3N0U2V0dXBQcm9maWxlV2FzSW5zdGFsbGVkPC9rZXk+Cgk8dHJ1ZS8+CjwvZGljdD4KPC9wbGlzdD4K"
        overwriteFile(try! Data(base64Encoded: data), "/var/containers/Shared/SystemGroup/systemgroup.com.apple.configurationprofiles/Library/ConfigurationProfiles/CloudConfigurationDetails.plist");
    }
}
