#!/usr/bin/env bash
#HUGO=${HOME}/bin/hugo
HUGO=hugo
echo "using $HUGO"

${HUGO} server --logLevel debug --disableFastRender $1
