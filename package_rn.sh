#!/bin/bash -il
source ~/.bashrc
Enviroment=$1
cd ./RN
# 安装依赖
yarn install
# link
./node_modules/.bin/react-native link
echo "-------------------------------------进入静态文件打包环节-------------------------------------"
# 静态文件打包
BundlePath='YourProjectDir/main.jsbundle'
AssetsPath='YourProjectDir'
./node_modules/.bin/react-native bundle \
				--entry-file index.js \
  				--bundle-output ${BundlePath} \
  				--platform ios \
  				--assets-dest ${AssetsPath} \
  				--dev false