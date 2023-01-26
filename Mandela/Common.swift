//
//  Common.swift
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-26.
//

import Foundation
// MARK: - plist editing function
func plistChangeStr(plistPath: String, key: String, value: String) {
    let stringsData = try! Data(contentsOf: URL(fileURLWithPath: plistPath))
    
    let plist = try! PropertyListSerialization.propertyList(from: stringsData, options: [], format: nil) as! [String: Any]
    func changeValue(_ dict: [String: Any], _ key: String, _ value: String) -> [String: Any] {
        var newDict = dict
        for (k, v) in dict {
            if k == key {
                newDict[k] = value
            } else if let subDict = v as? [String: Any] {
                newDict[k] = changeValue(subDict, key, value)
            }
        }
        return newDict
    }

    var newPlist = plist
    newPlist = changeValue(newPlist, key, value)

    let newData = try! PropertyListSerialization.data(fromPropertyList: newPlist, format: .binary, options: 0)

    overwriteFile(newData, plistPath)
}

// MARK: - plist editing function
func plistChangeInt(plistPath: String, key: String, value: Int) {
let stringsData = try! Data(contentsOf: URL(fileURLWithPath: plistPath))

let plist = try! PropertyListSerialization.propertyList(from: stringsData, options: [], format: nil) as! [String: Any]
func changeValue(_ dict: [String: Any], _ key: String, _ value: Int) -> [String: Any] {
    var newDict = dict
    for (k, v) in dict {
        if k == key {
            newDict[k] = value
        } else if let subDict = v as? [String: Any] {
            newDict[k] = changeValue(subDict, key, value)
        }
    }
    return newDict
}

var newPlist = plist
newPlist = changeValue(newPlist, key, value)

let newData = try! PropertyListSerialization.data(fromPropertyList: newPlist, format: .binary, options: 0)

overwriteFile(newData, plistPath)
}
