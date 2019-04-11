#/bin/sh

# build路径
DEST=${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}
# bundle的需要拷贝到路径
BUNDLE_FILE="$DEST/main.jsbundle"
BUNDLE_META_FILE="$DEST/main.jsbundle.meta"
# assets的需要拷贝到路径
ASSET_FILE="$DEST/assets"
ROOT_PATH=${SRCROOT}
cd $ROOT_PATH
SOURCE_FILE_PATH="$(pwd)"
echo "$SOURCE_FILE_PATH"
ORIGIN_BUNDLE_FILE="$SOURCE_FILE_PATH/main.jsbundle"
ORIGIN_BUNDLE_META_FILE="$SOURCE_FILE_PATH/main.jsbundle.meta"
ORIGIN_ASSET_FILE="$SOURCE_FILE_PATH/assets"
echo "$ORIGIN_BUNDLE_FILE"
echo "$ORIGIN_ASSET_FILE"

if [ ! -f "$ORIGIN_BUNDLE_FILE" ];then
	echo "bundle不存在"
else
	echo "begin cp bundle"
	cp ${ORIGIN_BUNDLE_FILE} ${BUNDLE_FILE}
    cp ${ORIGIN_BUNDLE_META_FILE} ${BUNDLE_META_FILE}
	echo "end cp bundle"
fi
if [ ! -d "$ORIGIN_ASSET_FILE" ];then
	echo "assets不存在"
else
	echo "begin cp assets"
	cp -r ${ORIGIN_ASSET_FILE} ${ASSET_FILE}
	echo "end cp assets"
fi
