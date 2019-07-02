#!/usr/bin/env sh

TEMPLATES_DIR="$HOME/Library/Developer/Xcode/Templates"
FILE_TEMPLATES_DIR="$TEMPLATES_DIR/File Templates"
KIWI_TEMPLATES_DIR="$FILE_TEMPLATES_DIR/Custom"
KIWI_SPEC_TEMPLATE="$KIWI_TEMPLATES_DIR/Custom.xctemplate"
echo "Removing $CUSTOM_TEMPLATES_DIR"
rm -rf "$CUSTOM_TEMPLATES_DIR/Custom.xctemplate"
echo "Finished"
