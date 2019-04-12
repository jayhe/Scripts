pipeline {
  	agent {
    	node {
      	label 'mac'
    	}
 	}
  	environment {
    	NVM_NODEJS_ORG_MIRROR = 'https://npm.taobao.org/mirrors/node/'
    	NODEJS_ORG_MIRROR = 'https://npm.taobao.org/mirrors/node/'
    	PATH = "${env.PATH}:${env.HOME}/.nvm/versions/node/v8.11.1/bin:/usr/local/bin"
    	SKIP_BUNDLING = true
    	DINGDING_ROBOT_URL = 'YourDingDingWebhookKey'
  	}    
	
	stages {
		stage('拉取代码'){
			// 并行拉取代码
			parallel {
				stage('拉取RN代码'){
					steps {
						checkout([$class: 'GitSCM', 
		    					branches: [[name: '$RN_BRANCH']], 
		    					doGenerateSubmoduleConfigurations: false, 
		    					extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'RN']], 
		    					submoduleCfg: [],
		    					userRemoteConfigs: [[credentialsId: 'chao.he', url: 'https://xxx.git']]])
						  }
				}
				stage('拉取Native代码'){
					steps {
						checkout([$class: 'GitSCM', 
		    					branches: [[name: '$NATIVE_BRANCH']], 
		    					doGenerateSubmoduleConfigurations: false, 
		    					extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'Native']], 
		    					submoduleCfg: [],
		    					userRemoteConfigs: [[credentialsId: 'chao.he', url: 'https://xxx.git']]])
    			
						 }
				}
			}
		}
		stage('打包'){     
            stages{
            	stage('打包RN') {
					steps {
						// shell_path是脚本的路径
						sh "chmod 777 ./shell_path/package_rn.sh"
						sh "./shell_path/package_rn.sh ${env.ENVIRONMENT}"
					}
				}
				stage('导出ipa') {
					steps {
						// shell_path是脚本的路径
						sh "chmod 777 ./shell_path/export_ipa.sh"
						sh "./shell_path/export_ipa.sh ${env.ENVIRONMENT}"
						script {
							def packageName = createPackageName()
							// 凡事涉及到YourAppName的都需要改成自己的appName
							sh "cp Package/YourAppName/YourAppName.ipa Package/YourAppName/${env.PACKAGE_NAME}"
						}
					}
				}
				stage('归档成品') {
					steps {
						archiveArtifacts "Package/YourAppName/${env.PACKAGE_NAME}"
					}
				}
				stage('上传蒲公英') {
					steps {
						script {
							if(env.UPLOAD_PGY == 'true') {
								// 这里的file路径需要是ipa的文件路径，YourPGYAPPKey就是pgy的APP Key
								sh 'curl -F "file=@./YourIpaFullPath" \
									 	 -F "_api_key=YourPGYAPPKey" \
									 	 -F "buildInstallType=1" \
									 	 http://www.pgyer.com/apiv2/app/upload \
									 	 -o ./pgy.json'
							} else {
								echo '不上传'
							}	
						}
					}
				}
            }
		}
	}

	post {
    success {
      script {
        def rawmsg = successNotifyData()
        sh "curl -H 'Content-Type:application/json' -X POST --data '${rawmsg}' ${env.DINGDING_ROBOT_URL}"
      }
    }

    failure {
      script {
        def rawmsg = failNotifyData()
        sh "curl -H 'Content-Type:application/json' -X POST --data '${rawmsg}' ${env.DINGDING_ROBOT_URL}"
      }
    }
  }
}


def failNotifyData() {
  def title = "YourAppName 构建失败[${env.BUILD_NUMBER}]"
  def markdown = "### ${title}\n #### 摘要 > buildUrl: ${env.BUILD_URL} \n > [点击查看](${env.BUILD_URL}console)"
  return buildJSON(title, markdown)
}

def successNotifyData() {
  def url = "${env.BUILD_URL}/Package/YourAppName/YourAppName.ipa";
  def title = "YourAppName 构建成功 [${env.BUILD_NUMBER}]"
  def markdown = "### ${title}\n #### 构建结果: \n * [YourAppName.ipa](${url}) \n > buildUrl: ${env.BUILD_URL} \n"
  if(env.UPLOAD_PGY == 'true') {
  	def downloadUrl = createPGYDownloadURL()
  	def qrUrl = createPGYQRURL()
  	markdown = "### ${title}\n #### 构建结果: \n * [YourAppName.ipa](${url}) \n * buildUrl: ${env.BUILD_URL} \n * pgyUrl: ${downloadUrl}\n ${qrUrl}"
  }
  return buildJSON(title, markdown)
}

def buildJSON(title, markdown) {
  return """
  {
    "msgtype": "markdown",
    "markdown": {
      "title":"${title}",
      "text":"${markdown}"
    }
  }
  """
}
// 获取蒲公英的app下载地址
def createPGYDownloadURL() {
	def buildShortcutUrl = sh(returnStdout: true, script: 'cat pgy.json | jq -r ".data.buildShortcutUrl"')
	echo buildShortcutUrl
	def downloadUrl = "http://www.pgyer.com/${buildShortcutUrl}"
	echo downloadUrl
	return downloadUrl
}
// 获取蒲公英的app的二维码地址
def createPGYQRURL() {
  def buildQRCodeURL = sh(returnStdout: true, script: 'cat pgy.json | jq -r ".data.buildQRCodeURL"')
  echo buildQRCodeURL
  return buildQRCodeURL
}

def createPackageName() {
  def appFlag = 'YourAppName'  
  // 版本号
  // def appVersion = '2.0.1'
  def appVersion = sh(returnStdout: true, script: '/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" "YourAppInfoPlistPath"').trim()

  // 构建时间，注意时区
  def buildTime = new Date().format('yyMMddhhMM', TimeZone.getTimeZone('GMT+8:00'));
  // 文件后缀
  def subfix = "ipa"
  
  def packageName = "${appFlag}_${appVersion}_${buildTime}.${subfix}"
  env.PACKAGE_NAME = packageName;
  return packageName;
}