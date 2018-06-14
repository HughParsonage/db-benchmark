#!/bin/bash
set -e

echo 'upgrading pydatatable...'

# at this point python virtual env should be sourced and LLVM6 env var set

rm -rf ./tmp/datatable
mkdir -p ./tmp/datatable

git clone --depth=1 https://github.com/h2oai/datatable.git ./tmp/datatable
cd tmp/datatable
make clean
make build
make install

cd ../..
rm -rf ./tmp/datatable