#!/bin/bash -il

export LC_ALL=en_US.UTF-8

source ~/.bashrc
# 存储所有版本号的打包版本信息文件夹【一个版本对应一个json避免一个json导致打了不同的版本的包覆盖的情况】，这个文件夹由外部传入，一般放到Jenkins的主目录
BuildNumberPath=$1
if [[ ! -d $BuildNumberPath ]]; then
    mkdir $BuildNumberPath
    chmod 777 $BuildNumberPath
    echo ${BuildNumberPath}
else
    echo ${BuildNumberPath} 
fi
# 版本号自增
PlistDir="YourProjectInfoPlistPath"
BuildVersion=$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "${PlistDir}")
BuildJsonPath=${BuildNumberPath}/${BuildVersion}.json
echo ${BuildJsonPath}
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