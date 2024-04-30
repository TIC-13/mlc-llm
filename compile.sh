#!/bin/bash

rm -rf ${MLC_LLM_HOME}/build/
mkdir -p ${MLC_LLM_HOME}/build/
cd ${MLC_LLM_HOME}/build/

python3 ../cmake/gen_cmake_config.py

cmake .. && cmake --build . --parallel $(nproc) && cd ..
