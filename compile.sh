#!/bin/bash

mkdir -p {build,dist}
cd build

cmake ../5.6.22  -DCMAKE_INSTALL_PREFIX=$(pwd)/../dist \
  -DMYSQL_DATADIR=$(pwd)/../dist/data -DWITH_DEBUG=1 -DCMAKE_BUILD_TYPE=DEBUG \
  -DCMAKE_C_FLAGS_DEBUG="-g -O0" -DCMAKE_CXX_FLAGS_DEBUG="-g -O0" \
  -DMYSQL_MAINTAINER_MODE=false

make -j4
if [ $? -ne 0 ]; then
  echo "Failed to build mysql"
  exit 1
fi
make install
cd ..
./init_db.sh
echo "export PSANDBOX_MYSQL_DIR=`pwd`/dist" >> $HOME/.bashrc
echo "export LD_LIBRARY_PATH=`pwd`/dist/lib:$LD_LIBRARY_PATH" >> $HOME/.bashrc
echo "export PATH=`pwd`/dist/bin:$PATH" >> $HOME/.bashrc

