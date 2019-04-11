# Type a script or drag a script file from your workspace to insert its path.
export PATH=$PATH:/usr/libexec

echo ${CONFIGURATION_BUILD_DIR}
echo ${SRCROOT}
echo ${PROJECT_DIR}
cd ${SRCROOT}/CassECommerce.xcodeproj

Config=${CONFIGURATION}
UseActiveArch=NO
if [[ $Config != 'Debug' ]]; then
echo modify project config

PlistBuddy -c "Set :objects:1001BE4321D5B3C000263560:buildSettings:ONLY_ACTIVE_ARCH $UseActiveArch" project.pbxproj
PlistBuddy -c "Set :objects:1030F19521F56362009CC73C:buildSettings:ONLY_ACTIVE_ARCH $UseActiveArch" project.pbxproj
PlistBuddy -c "Set :objects:1030F19221F56354009CC73C:buildSettings:ONLY_ACTIVE_ARCH $UseActiveArch" project.pbxproj

echo finished modify
fi

