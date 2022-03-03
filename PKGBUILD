# Maintainer: Aksel Alpay <aksel.alpay at uni-heidelberg dot de>
# Maintainer: acxz <akashpatel2008 at yahoo dot com>

pkgname=hipsycl-cuda-git
pkgver=r1756.3db975f
pkgrel=1
pkgdesc="Implementation of SYCL 1.2.1 over AMD HIP/NVIDIA CUDA"
arch=("x86_64")
url="https://github.com/illuhad/hipSYCL"
license=("BSD")
provides=(hipsycl hipsycl-cpu hipsycl-cuda sycl)
makedepends=(cmake)
depends=(cuda boost clang llvm)
_pkgname=hipsycl

# 3db975ffc15d54ba536029c286f57e789f86b29c 
# e38ed92163c575f85c9a32cfd2ae4b057010baf7 <- bad

# 3db975f
# e38ed92 <- bad
# tag=v0.9.2

#source=("${_pkgname}::git+https://github.com/illuhad/hipSYCL.git#tag=v0.9.2")
source=("${_pkgname}::git+https://github.com/illuhad/hipSYCL.git#commit=3db975f")
sha256sums=('SKIP')

pkgver() {
    cd "${_pkgname}"
    printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

prepare() {
    # Delete the install lines for contrib hip and hipcpu
    sed -i '/contrib/d' ${srcdir}/${_pkgname}/CMakeLists.txt
}

build() {
    mkdir -p ${srcdir}/${_pkgname}/build
    cd ${srcdir}/${_pkgname}/build

    cmake .. -DCMAKE_BUILD_TYPE=Release \
          -DWITH_CPU_BACKEND=ON \
          -DWITH_CUDA_BACKEND=ON \
          -DWITH_ROCM_BACKEND=OFF \
          -DCLANG_INCLUDE_PATH=/usr/include/clang
          #-DCMAKE_INSTALL_PREFIX=/opt/hipSYCL

    make
          #-DCUDA_TOOLKIT_ROOT_DIR=/opt/cuda-10.0
          #-DWITH_CUDA_BACKEND=ON \
          #-DWITH_ROCM_BACKEND=OFF \
}

package() {
    cd "${srcdir}/${_pkgname}/build"
    make DESTDIR=${pkgdir} install
}
