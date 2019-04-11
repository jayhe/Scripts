node {
    checkout([$class: 'GitSCM', 
        branches: [[name: '$NATIVE_BRANCH']], 
        doGenerateSubmoduleConfigurations: false, 
        extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'Native']], 
        submoduleCfg: [],
        userRemoteConfigs: [[credentialsId: 'chao.he', url: 'https://xxx.git']]])
    checkout([$class: 'GitSCM', 
        branches: [[name: '$RN_BRANCH']], 
        doGenerateSubmoduleConfigurations: false, 
        extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'RN']], 
        submoduleCfg: [],
        userRemoteConfigs: [[credentialsId: 'chao.he', url: 'https://xxx.git']]])
}

node {
    sh label: '', script: '''#!/bin/bash -il

source ~/.bashrc

cd ./RN
# 安装依赖
yarn install
# link
./node_modules/.bin/react-native link
# 更新配置
./scripts/update-config.sh ${Environment}
echo "-------------------------------------进入静态文件打包环节-------------------------------------"
# 静态文件打包
BundlePath=\'../YourProjectDir/main.jsbundle\'
AssetsPath=\'../YourProjectDir\'
./node_modules/.bin/react-native bundle \\
  --entry-file index.js \\
  --bundle-output ${BundlePath} \\
  --platform ios \\
  --assets-dest ${AssetsPath} \\
  --dev false

echo "-------------------------------------进入APP打包环节-------------------------------------------"
# 打包ipa
cd ./YourProjectDir
Workspace=\'YourApp.xcworkspace\'
Scheme=\'YourAppScheme\'
Configuration="Release"
PackageDir=../../Package
ArchivePath=${PackageDir}/${Scheme}.xcarchive
ExportIpaPath=${PackageDir}/${Scheme}
ExportPlistDir=../ExportOptions
if [ -z $Environment ] || [ $Environment = "development" ] || [ $Environment = "test" ] || [ $Environment = "demo" ]; then
  echo "开发环境打包"
  # 打包配置文件绝对路径
  ExportPlistPath=${ExportPlistDir}/DevelopmentExportOptionsPlist.plist
elif [ "$1" = "production" ]; then
  echo "生产环境打包"
  # 打包配置文件绝对路径
  ExportPlistPath=${ExportPlistDir}/DistributionExportOptionsPlist.plist
else
  exit "替换文件失败"
fi

# 编译前清理工程
xcodebuild clean -workspace ${Workspace} \\
                 -scheme ${Scheme} \\
                 -configuration ${Configuration}

xcodebuild archive -workspace ${Workspace} \\
                   -scheme ${Scheme} \\
                   -configuration ${Configuration} \\
                   -archivePath ${ArchivePath}

xcodebuild  -exportArchive \\
      -archivePath ${ArchivePath} \\
            -exportPath ${ExportIpaPath} \\
            -exportOptionsPlist ${ExportPlistPath}
            

echo "-------------------------------------发送钉钉提醒---------------------------------------------"
# send dingding msg
if [ -f ${ExportIpaPath}/YourAppName.ipa ];
then 
./notify.sh true ${BUILD_URL}Package/${Scheme}/YourAppName.ipa $BUILD_NUMBER YourAppName-$Environment
else 
./notify.sh false $BUILD_URL $BUILD_NUMBER YourAppName-$Environment
fi'''
}

