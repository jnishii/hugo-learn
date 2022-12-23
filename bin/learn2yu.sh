#!/bin/bash

SOURCE=${HOME}/Sites/hugo-learn/
DEST=${HOME}/mnt/web/public_html/notebook

hugo -s ${HOME}/Sites/hugo-learn/ \
        -b /~jun/notebook \
        -d ${DEST} 
#        --cleanDestinationDir

#                       -b http://bcl.sci.yamaguchi-u.ac.jp/~jun/ \
#               -b http://ds0n.cc.yamaguchi-u.ac.jp/~nishii/ \
