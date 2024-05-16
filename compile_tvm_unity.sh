#!/bin/bash

echo "This process will take a while, please be patient.\n"
sleep 3

# Prepare and clean build
rm -rf ${TVM_HOME}/build
mkdir -p ${TVM_HOME}/build
cd ${TVM_HOME}
make clean
cd ${TVM_HOME}/build/

cp ../cmake/config.cmake .
# controls default compilation flags
echo "set(CMAKE_BUILD_TYPE RelWithDebInfo)" >> config.cmake
# LLVM is a must dependency
echo "set(USE_LLVM \"llvm-config --ignore-libllvm --link-static\")" >> config.cmake
echo "set(HIDE_PRIVATE_SYMBOLS ON)" >> config.cmake
# GPU SDKs, turn on if needed
echo "set(USE_CUDA   OFF)" >> config.cmake
echo "set(USE_METAL  OFF)" >> config.cmake
echo "set(USE_VULKAN OFF)" >> config.cmake
echo "set(USE_OPENCL OFF)" >> config.cmake
# FlashInfer related, requires CUDA w/ compute capability 80;86;89;90
echo "set(USE_FLASHINFER OFF)" >> config.cmake
echo "set(FLASHINFER_CUDA_ARCHITECTURES YOUR_CUDA_COMPUTE_CAPABILITY_HERE)" >> config.cmake
echo "set(CMAKE_CUDA_ARCHITECTURES YOUR_CUDA_COMPUTE_CAPABILITY_HERE)" >> config.cmake

cmake .. && cmake --build . --parallel $(($(nproc) - 2))

# Install dependencies and package
cd ${TVM_HOME}/python/
pip install -e . --break-system-packages

# Check TVM instalation
python -c "import tvm; print(tvm.__file__)"
python -c "import tvm; print(tvm._ffi.base._LIB)"
python -c "import tvm; print('\n'.join(f'{k}: {v}' for k, v in tvm.support.libinfo().items()))"