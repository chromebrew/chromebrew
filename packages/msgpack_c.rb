# Adapted from Arch Linux msgpack-c PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/msgpack-c/trunk/PKGBUILD

require 'buildsystems/cmake'

class Msgpack_c < CMake
  description 'An efficient object serialization library'
  homepage 'https://msgpack.org/'
  version '6.0.0'
  license 'custom:Boost'
  compatibility 'all'
  source_url 'https://github.com/msgpack/msgpack-c/releases/download/c-6.0.0/msgpack-c-6.0.0.tar.gz'
  source_sha256 '3654f5e2c652dc52e0a993e270bb57d5702b262703f03771c152bba51602aeba'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '954cc5887ce7be419b0571bbfd8da72c436a83d0d7c0ac4f0033e8191cc69be1',
     armv7l: '954cc5887ce7be419b0571bbfd8da72c436a83d0d7c0ac4f0033e8191cc69be1',
       i686: '23f44da7a26b62bc6b38be11b7c2a5cefc1b2ac11a5d87982f73a4a2edb8ad03',
     x86_64: '4171f5ad1d9e9b4e40b06e0e9f68173edace4f25d7d95e8b1f9e581e45a87f7d'
  })

  depends_on 'doxygen' => :build
  depends_on 'glibc' # R

  def self.patch
    system "sed -i 's,exec_prefix}/lib,exec_prefix}/#{ARCH_LIB},g' CMakeLists.txt"
    system "sed -i 's,CMAKE_INSTALL_PREFIX}/lib,CMAKE_INSTALL_PREFIX}/#{ARCH_LIB},g' CMakeLists.txt"
    system "sed -i 's,CMAKE_INSTALL_LIBDIR lib,CMAKE_INSTALL_LIBDIR #{ARCH_LIB},g' CMakeLists.txt"
  end

  cmake_options "-DCMAKE_C_STANDARD='17' \
      -DBUILD_SHARED_LIBS=ON \
      -DMSGPACK_ENABLE_STATIC=OFF \
      -DMSGPACK_BUILD_EXAMPLES=OFF \
      -DMSGPACK_BUILD_TESTS=OFF"
end
