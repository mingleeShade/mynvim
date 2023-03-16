#!/bin/bash

INSALL_DIR=~/.config/nvim/

cp -v ./*.vim ${INSALL_DIR}
cp -v ./coc-settings.json ${INSALL_DIR}
cp -v ./cpp_farignore ${INSALL_DIR}
mkdir -pv ${INSALL_DIR}/lua
cp -v ./lua/*.lua ${INSALL_DIR}/lua/

# 放到 ~/.zshrc 中
#export OPENAI_API_KEY=xxxxx
echo "确认 ChatGPT 的 api key 设置正确，到笔记里查找"
