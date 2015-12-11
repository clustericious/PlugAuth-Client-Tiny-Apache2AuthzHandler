#!/bin/bash

#set -euo pipefail
#IFS=$'\n\t'

mkdir -p /tmp/build/apr /tmp/build/apr-util

cd /tmp/build/apr
curl http://www.motorlogy.com/apache/apr/apr-1.5.2.tar.gz | tar zxvf -
cd apr-1.5.2
./configure --prefix=/usr && make && sudo make install

cd /tmp/build/apr-util
curl http://www.motorlogy.com/apache/apr/apr-util-1.5.4.tar.gz | tar zxvf -
cd apr-util-1.5.4
./configure --prefix=/usr --with-apr=/usr/bin && make && sudo make install

