#!/bin/bash -il

export LC_ALL=en_US.UTF-8

source ~/.bashrc
# 打包本地存储的打包信息json路径
BuildJsonPath=$1
echo ${BuildJsonPath}
# 版本号自增
PlistDir='YourAppInfo.plist dir'
BuildVersion=$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "${PlistDir}")
if [[ -f $BuildJsonPath ]]; then
# 读取Json中上次打包的build信息
    echo "读取Json中上次打包的build信息"
    PreBuildVersion=`cat ${BuildJsonPath} | jq -r ".BuildVersion"`
    PreBuildNumber=`cat ${BuildJsonPath} | jq -r ".BuildNumber"`
    echo "PreBuildVersion:${PreBuildVersion}"
    echo "PreBuildNumber:${PreBuildNumber}"
    echo "Plist中BuildVersion:${BuildVersion}"
else
# 使用项目Info.plist的信息
    echo "使用项目Info.plist的信息"
    BuildNumber=$(/usr/libexec/PlistBuddy -c "Print :CFBundleVersion" "${PlistDir}")
    echo "Plist中BuildNumber:${BuildNumber}"
fi

if [ "${PreBuildVersion}" == "${BuildVersion}" ]; then
	echo "版本号未改变"
    BuildNumber=`expr ${PreBuildNumber} + 1`
else
	echo "版本号改变"
    BuildNumber=$(/usr/libexec/PlistBuddy -c "Print :CFBundleVersion" "${PlistDir}")
	echo "BuildNumber:${BuildNumber}"
    BuildNumber=`expr ${BuildNumber} + 1`
fi

echo "自增之后BuildNumber:${BuildNumber}"

if [[ "${BuildNumber}" != "" ]]; then
	# 修改Info.plist的build号
	echo "修改Info.plist的build号"
	/usr/libexec/PlistBuddy -c "Set :CFBundleVersion ${BuildNumber}" "${PlistDir}"
	# 写本次打包信息到build.json
	echo "{\"BuildNumber\":\"${BuildNumber}\", \"BuildVersion\":\"${BuildVersion}\"}" > ${BuildJsonPath}
fi