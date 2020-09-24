#!/bin/bash -il
export LC_ALL=en_US.UTF-8

mv "/Applications/Beyond Compare.app/Contents/MacOS/BCompare" "/Applications/Beyond Compare.app/Contents/MacOS/BCompare.real"
echo "rm \"/Users/\$(whoami)/Library/Application Support/Beyond Compare/registry.dat\"" > "/Applications/Beyond Compare.app/Contents/MacOS/BCompare"
echo "\"\`dirname \"\$0\"\`\"/BCompare.real \$@" >> "/Applications/Beyond Compare.app/Contents/MacOS/BCompare"
chmod +x "/Applications/Beyond Compare.app/Contents/MacOS/BCompare"
chmod +x "/Applications/Beyond Compare.app/Contents/MacOS/BCompare.real"