#!/usr/bin/env sh

SOURCE_DIR=$(dirname "$0")
TEMPLATES_DIR="$HOME/Library/Developer/Xcode/Templates"
FILE_TEMPLATES_DIR="$TEMPLATES_DIR/File Templates"
CUSTOM_TEMPLATES_DIR="$FILE_TEMPLATES_DIR/Custom"

echo "Installing templates to $CUSTOM_TEMPLATES_DIR"
mkdir -p "$CUSTOM_TEMPLATES_DIR"
cp -R "$SOURCE_DIR/Custom.xctemplate" "$CUSTOM_TEMPLATES_DIR"
echo "Finished"
