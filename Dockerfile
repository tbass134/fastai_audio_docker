FROM python:3.7-slim
# WORKDIR /usr/src/app

#Check for SUDO, since fastai_audio install script uses SUDO
RUN if type sudo 2>/dev/null; then \
     echo "The sudo command already exists... Skipping."; \
    else \
     echo -e "#!/bin/sh\n\${@}" > /usr/sbin/sudo; \
     chmod +x /usr/sbin/sudo; \
    fi

RUN apt update && apt install -y \
  git \
  libffi-dev \
  libsox-dev \
  libsox-fmt-all \
  python3-dev \
  gcc \
  build-essential


ADD torch-1.1.0-cp37-cp37m-linux_x86_64.whl torch-1.1.0-cp37-cp37m-linux_x86_64.whl
ADD torchvision-0.3.0-cp37-cp37m-linux_x86_64.whl torchvision-0.3.0-cp37-cp37m-linux_x86_64.whl
ADD fastai-1.0.58-py3-none-any.whl fastai-1.0.58-py3-none-any.whl

RUN pip install torch-1.1.0-cp37-cp37m-linux_x86_64.whl
RUN pip install torchvision-0.3.0-cp37-cp37m-linux_x86_64.whl
RUN pip install fastai-1.0.58-py3-none-any.whl
RUN pip install IPython

RUN git clone https://github.com/mogwai/fastai_audio.git && \
  cd fastai_audio && \
  bash install.sh
