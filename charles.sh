#!/bin/bash -il
# coding=UTF-8
cd ~
SETTINGS_BIN="/Applications/Charles.app/Contents/Resources/Charles Proxy Settings" 
sudo chown root "${SETTINGS_BIN}" 
sudo chmod u+s "${SETTINGS_BIN}"