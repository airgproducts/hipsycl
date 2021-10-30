# Maintainer: Aksel Alpay <aksel.alpay at uni-heidelberg dot de>
# Maintainer: acxz <akashpatel2008 at yahoo dot com>

pkgname=hipsycl-cuda-git
pkgver=r1484.9ebaa0a
pkgrel=1
pkgdesc="Implementation of SYCL 1.2.1 over AMD HIP/NVIDIA CUDA"
arch=("x86_64")
url="https://github.com/illuhad/hipSYCL"
license=("BSD")
provides=(hipsycl hipsycl-cpu hipsycl-cuda sycl)
makedepends=(cmake)
depends=(cuda)
_pkgname=hipsycl
source=("${_pkgname}::git+https://github.com/illuhad/hipSYCL.git")
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
          -DWITH_ROCM_BACKEND=OFF
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
