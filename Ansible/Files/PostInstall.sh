#!/bin/bash

vim +PluginInstall +qall
cd $HOME/.vim/bundle/youcompleteme/
python3 install.py --clang-completer --go-completer
cd $HOME