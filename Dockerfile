FROM nvidia/cuda:11.0-devel as hipsycl

# Update NVIDIA's apt-key
# Announcement: https://forums.developer.nvidia.com/t/notice-cuda-linux-repository-key-rotation/212772
ENV DISTRO ubuntu1804
ENV CPU_ARCH x86_64
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$DISTRO/$CPU_ARCH/3bf863cc.pub

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y clang-12 libclang-12-dev git cmake libboost-all-dev
WORKDIR /root
RUN git clone https://github.com/illuhad/hipSYCL.git
WORKDIR /root/hipSYCL
RUN git checkout 3db975ffc15d54ba536029c286f57e789f86b29c
RUN mkdir build
WORKDIR /root/hipSYCL/build

RUN cmake .. -DCMAKE_BUILD_TYPE=Release \
          -DWITH_CPU_BACKEND=ON \
          -DWITH_CUDA_BACKEND=ON \
          -DWITH_ROCM_BACKEND=OFF \
          -DCLANG_INCLUDE_PATH=/usr/include/clang

RUN make -j $(nproc)
RUN make install