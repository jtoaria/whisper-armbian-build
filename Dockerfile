# Base Image Resmi (Dijamin Publik)
FROM ubuntu:22.04

# Set Environment Non-Interaktif
ENV DEBIAN_FRONTEND=noninteractive

# Instalasi Dependensi dan Kompilasi
RUN apt update && \
    apt install -y git cmake build-essential wget && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Clone dan Kompilasi Whisper.cpp di dalam image
RUN cd /tmp && \
    git clone https://github.com/ggerganov/whisper.cpp.git whisper.cpp && \
    cd whisper.cpp && \
    make -j 1

# Unduh Model
RUN cd /tmp/whisper.cpp && \
    ./models/download-ggml-model.sh base

# Set Direktori Kerja
WORKDIR /tmp/whisper.cpp

# Perintah agar container tetap running
CMD ["tail", "-f", "/dev/null"]
