# Mandela
Simple customization app using CVE-2022-46689

## Disclaimer
I am not responsible for any damage to your device. Use this app at your own risk.

## Building instructions

```
git clone https://github.com/BomberFish/Mandela.git
cd Mandela
xcodebuild -project Mandela.xcodeproj -scheme Mandela -sdk iphoneos -configuration Release CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO
```
