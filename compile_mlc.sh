#!/bin/bash

rm -rf ${MLC_LLM_HOME}/build/
mkdir -p ${MLC_LLM_HOME}/build/
cd ${MLC_LLM_HOME}/build/

python3 ../cmake/gen_cmake_config.py

cmake .. && cmake --build . --parallel $(($(nproc) - 2))

# rm -f ${MLC_LLM_HOME}/3rdparty/libtvm_runtime.so
# ln -s ${MLC_LLM_HOME}/build/tvm/libtvm_runtime.so ${MLC_LLM_HOME}/3rdparty/libtvm_runtime.so
# rm -f ${MLC_LLM_HOME}/3rdparty/libtvm.so
# ln -s ${MLC_LLM_HOME}/build/tvm/libtvm.so ${MLC_LLM_HOME}/3rdparty/libtvm.so

cd ${MLC_LLM_HOME}/python/
pip install -e . --break-system-packages


# ln -s ${MLC_LLM_HOME}/build/tvm/ ${TVM_HOME}/build/
