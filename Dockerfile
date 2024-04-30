FROM ubuntu:22.04

ENV TZ=America/Recife
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get install -y build-essential cmake neovim nano wget curl tar git python3-pip

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc && \
    echo "export MLC_LLM_HOME=/volume" >> ~/.bashrc && \
    echo "export PYTHONPATH=/volume/python:$PYTHONPATH" >> ~/.bashrc
    
CMD ["/bin/bash"]

