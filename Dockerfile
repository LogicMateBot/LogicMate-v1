FROM deepnote/python:3.8
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libgl1-mesa-dev \
    ffmpeg

RUN wget https://developer.download.nvidia.com/compute/cuda/12.1.0/local_installers/cuda_12.1.0_530.30.02_linux.run && \
    chmod +x cuda_12.1.0_530.30.02_linux.run && \
    sudo sh cuda_12.1.0_530.30.02_linux.run --silent --toolkit && \
    rm cuda_12.1.0_530.30.02_linux.run

RUN sudo ln -sfn /usr/local/cuda-12.1 /usr/local/cuda

RUN pip install gdown && \
    gdown --folder "https://drive.google.com/drive/folders/1Vu_7uu6yt7aPthTN5snwtvEwz4SjM_6-" && \
    if [ -d "Drivers" ]; then \
      cd Drivers && \
      dpkg -i cudnn-local-repo-debian11-8.9.7.29_1.0-1_amd64.deb && \
      cp /var/cudnn-local-repo-debian11-8.9.7.29/*keyring.gpg /usr/share/keyrings/; \
    fi && \
    apt-get update && \
    apt-get install -y libcudnn8=8.9.7.29-1+cuda12.2 libcudnn8-dev=8.9.7.29-1+cuda12.2 libcudnn8-samples=8.9.7.29-1+cuda12.2

ENV CUDA_HOME="/usr/local/cuda"
ENV PATH="/usr/local/cuda/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"