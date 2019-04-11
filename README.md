# Scripts
日常工作中的一些脚本

#### Jenkinsfile
> * 多仓库代码异步拉取
> * stages的使用
> * 自定义ipa包名--需要获取到app的版本用到`/usr/libexec/PlistBuddy`
> * 上传到蒲公英并获取下载地址
> * 发送markdown格式的钉钉消息

#### export_ipa.sh
> 导出ipa包的脚本

#### package_rn.sh
> 打包RN的脚本

#### cp-rn-resources.sh
> xcode编译时使用该脚本将项目文件目录小的资源文件拷贝到app的build路径下

#### modify_config.sh
> 修改xcode的project配置的脚本

#### notify.sh
> 发送钉钉消息的脚本

#### oclint.sh
> 静态分析生成pmd文档的脚本

#### export_ipa_no_pipline_stageview.sh
> 拉取代码打包ipa发钉钉消息的脚本。同Jenkinsfile的差别就是在jenkins上不会展示stageview
