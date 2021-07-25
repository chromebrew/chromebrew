#!/bin/bash

sed -i "s:bsdgame 'self':bsdgame = '${1}':" ${1}.rb
