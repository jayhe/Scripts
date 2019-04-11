#!/bin/bash
#-*- coding:utf-8 -*-

rawmsg=""
dingtalk="https://oapi.dingtalk.com/robot/send?access_token=5cb8f457c5614c11dd4f347a4ddddebd66cf8cef12e64a9c1f56827d7641dc6e"
isSuccess=$1
url=$2
title=$4
buildNumber=$3
markdown=""

getNotifyData() {
  if [[ $isSuccess == true ]]; then
    title="${title} 构建成功 [${buildNumber}]"
    echo $title
  else
    title="${title} 构建失败 [${buildNumber}]"
    echo $title
  fi
  markdown="### ${title}\n #### 构建结果: \n > 地址: ${url} \n"
  rawmsg="
  {\"msgtype\": \"markdown\", 
    \"markdown\": {
        \"title\": \"${title}\",
        \"text\": \"${markdown}\"
     }
  }"
}

notify() {
  getNotifyData
  curl "${dingtalk}" \
   -H "Content-Type:application/json" \
   -X POST \
   -d "${rawmsg}"
}

notify;
