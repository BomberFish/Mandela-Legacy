# How to add your own mods!

Adding your own mods to Mandela is a simple process, given you know what to do. First, you want to make a new group in the Mandela/Views folder. Then, create a SwiftUI view. 

I **strongly** recommend using the included copy of the CVE-2022-46689 PoC, since adding your own versions might break things. 

You can overwrite files with the following function:
```swift
OverwriteFile(newFileData: newData, targetPath: /path/to/file)
```
 If you need to change the value of a key in a plist, look in IslandView.swift for an implementation.

Happy modding!
