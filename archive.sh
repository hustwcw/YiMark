
# modify APPID, Bundle Display Name and the Website url
if [ $# -ne 3 ];then
echo "usage: argument 1:APPID 2:APPName 3:URL"
exit 1
fi
APPID=$1
APPName=$2
URL=$3

echo $2

/usr/libexec/plistbuddy -c "SET :CFBundleDisplayName '$2'" ./YiMark/YiMark-Info.plist

cat <<EOF > YiMark/test.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Website</key>
	<string>$3</string>
</dict>
</plist>