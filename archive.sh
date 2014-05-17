# 脚本接收4个参数:AppID, AppName, AppIcon, URL
if [ $# -ne 3 ];then
echo "usage: argument 1:APPID 2:APPName 3:URL"
exit 1
fi

# modify APPID, Bundle Display Name and the Website url
sed  -i -e "/CFBundleIdentifier/{n; s/\(<string>\).*\(<\/string>\)/\1com.yimark.$1\2/; }" ./YiMark/YiMark-Info.plist
sed  -i -e "/CFBundleDisplayName/{n; s/\(<string>\).*\(<\/string>\)/\1$2\2/; }" ./YiMark/YiMark-Info.plist
#/usr/libexec/plistbuddy -c "SET :CFBundleDisplayName "$2"" ./YiMark/YiMark-Info.plist
#sed  -i -e "/Website/{n; s/\(<string>\).*\(<\/string>\)/\1$3\2/; }" ./YiMark/config.plist
/usr/libexec/plistbuddy -c "SET :Website '$4'" ./YiMark/config.plist

# 
srcDir=`pwd`
curl -o Icon.png $3
xcodebuild -target YiMark -sdk iphoneos build
xcrun -sdk iphoneos PackageApplication -v "build/Release-iphoneos/YiMark.app" -o "$srcDir/build/release/$1.ipa" --sign "hangzhou caizhu network technology co., LTD." --embed "Inhouse_Distribution.mobileprovision"
