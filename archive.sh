# 脚本接收4个参数:AppID, AppName, IconURL, WebURL
if [ $# -ne 4 ];then
echo "usage: argument 1:APPID 2:APPName 3:IconURL 4:WebURL"
exit 1
fi

srcDir="/Users/tck/Documents/Projects/YiMark"
# modify APPID, Bundle Display Name and the Website url
sed  -i -e "/CFBundleIdentifier/{n; s/\(<string>\).*\(<\/string>\)/\1com.yimark.$1\2/; }" $srcDir/YiMark/YiMark-Info.plist
sed  -i -e "/CFBundleDisplayName/{n; s/\(<string>\).*\(<\/string>\)/\1$2\2/; }" $srcDir/YiMark/YiMark-Info.plist
#/usr/libexec/plistbuddy -c "SET :CFBundleDisplayName "$2"" ./YiMark/YiMark-Info.plist
#sed  -i -e "/Website/{n; s/\(<string>\).*\(<\/string>\)/\1$3\2/; }" ./YiMark/config.plist
/usr/libexec/plistbuddy -c "SET :Website '$4'" $srcDir/YiMark/config.plist

#
curl -o "$srcDir/Icon.png" $3

security -v unlock-keychain -p "123456" "/Users/tck/Library/Keychains/login.keychain"
xcodebuild -target YiMark -sdk iphoneos build
xcrun -sdk iphoneos PackageApplication -v "$srcDir/build/Release-iphoneos/YiMark.app" -o "$srcDir/build/release/$1.ipa" --sign "hangzhou caizhu network technology co., LTD." --embed "$srcDir/Inhouse_Distribution.mobileprovision"
