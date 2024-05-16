FROM ubuntu:24.04

ENV TZ=America/Recife
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update
RUN apt-get install -y build-essential llvm-dev libzstd-dev cmake neovim nano wget curl tar eza git python3-full python3-pip

# Configure pip cache to be not need to be re-downloaded every time during the TVM/MLC build/installation
RUN mkdir -p /etc/xdg/pip/
RUN echo "[global]" >> /etc/xdg/pip/pip.conf
RUN echo "cache-dir = /volume/.cache/pip" >> /etc/xdg/pip/pip.conf


# RUN pip install numpy psutil decorator --break-system-packages

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc && \
    echo "export MLC_LLM_HOME=/volume" >> ~/.bashrc && \
    echo "export PYTHONPATH=/volume/python:$PYTHONPATH" >> ~/.bashrc \
    echo "export TVM_HOME=/volume/3rdparty/tvm" >> ~/.bashrc && \
    echo "export PYTHONPATH=/volume/3rdparty/tvm/python:$PYTHONPATH" >> ~/.bashrc

RUN echo 'alias python=python3' >> ~/.bashrc && \
    echo 'alias pip3=pip' >> ~/.bashrc && \
    echo 'alias ls=eza' >> ~/.bashrc && \
    echo 'alias lha="ls -lha"' >> ~/.bashrc

WORKDIR /volume

CMD ["/bin/bash"]

