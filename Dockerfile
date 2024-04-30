FROM ubuntu:24.04

ENV TZ=America/Recife
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update
RUN apt-get install -y build-essential cmake neovim nano wget curl tar git python3-full

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc && \
    echo "export MLC_LLM_HOME=/volume" >> ~/.bashrc && \
    echo "export PYTHONPATH=/volume/python:$PYTHONPATH" >> ~/.bashrc

RUN echo 'alias python=python3' >> ~/.bashrc && \
    echo 'alias pip=pip3' >> ~/.bashrc

WORKDIR /volume

CMD ["/bin/bash"]

