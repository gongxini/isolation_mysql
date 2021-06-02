#!/bin/bash

mkdir -p {build,dist}
cd build

cmake ../5.6.22  -DCMAKE_INSTALL_PREFIX=/home/psandbox/software/mysql/dist \
  -DMYSQL_DATADIR=/home/psandbox/software/mysql/dist/data -DWITH_DEBUG=1 -DCMAKE_BUILD_TYPE=DEBUG \
  -DCMAKE_C_FLAGS_DEBUG="-g -O0" -DCMAKE_CXX_FLAGS_DEBUG="-g -O0" \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DMYSQL_MAINTAINER_MODE=false

make -j4
if [ $? -ne 0 ]; then
  echo "Failed to build mysql"
  exit 1
fi
make install
