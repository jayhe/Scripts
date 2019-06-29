#!/bin/bash -il
export LC_ALL=en_US.UTF-8

source ~/.bashrc

java -jar closure-compiler.jar --js index.js \
--create_source_map ./cassecapp.js.map \
--js_output_file cassecapp.js \