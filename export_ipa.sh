#!/bin/bash -il
export LC_ALL=en_US.UTF-8

source ~/.bashrc

Enviroment=$1
echo ${Enviroment}
echo "-------------------------------------进入APP打包环节-------------------------------------------"
# 打包ipa
rm -rf Package
cd ./Native/YourProjectDir/
Workspace='YourApp.xcworkspace'
Scheme='YourAppScheme'
PackageDir=../../Package
ArchivePath=${PackageDir}/${Scheme}.xcarchive
ExportIpaPath=${PackageDir}/${Scheme}
ExportPlistDir=../ExportOptions
echo ${Enviroment}
if [ ${Enviroment} = "development" ] || [ ${Enviroment} = "test" ] || [ ${Enviroment} = "demo" ]; then
	echo "开发环境打包"
	# 打包配置文件绝对路径
	ExportPlistPath=${ExportPlistDir}/DevelopmentExportOptionsPlist.plist
	Configuration=`echo ${Enviroment} | perl -pe 's/.*/\u$&/'`
elif [ ${Enviroment} = "production" ]; then
	echo "生产环境打包"
	# 打包配置文件绝对路径
	ExportPlistPath=${ExportPlistDir}/DistributionExportOptionsPlist.plist
	Configuration='Release'
else
	exit "替换文件失败"
fi
echo ${Configuration}
# 编译前清理工程
xcodebuild clean -workspace ${Workspace} \
				-scheme ${Scheme} \
				-configuration ${Configuration}

xcodebuild archive -workspace ${Workspace} \
				   -scheme ${Scheme} \
				   -configuration ${Configuration} \
				   -archivePath ${ArchivePath}

xcodebuild -exportArchive \
		   -archivePath ${ArchivePath} \
		   -exportPath ${ExportIpaPath} \
		   -exportOptionsPlist ${ExportPlistPath}
