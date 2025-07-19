# Adapted from Arch Linux libluv PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libluv/trunk/PKGBUILD

require 'buildsystems/cmake'

class Libluv < CMake
  description 'Bare libuv bindings for lua'
  homepage 'https://github.com/luvit/luv'
  version '1.51.0-1'
  license 'apache'
  compatibility 'all'
  source_url 'https://github.com/luvit/luv.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0121098ecef7a9db78e45aa493ac90a3ca4ee700b14edd4d4428bc18bf5fa607',
     armv7l: '0121098ecef7a9db78e45aa493ac90a3ca4ee700b14edd4d4428bc18bf5fa607',
       i686: '33d1eef042ad5f8ab62a22cc62dccdced090c4f685ebe229768726da329bde17',
     x86_64: '0b5162c9d446e3593fb97441066ec8742ad3e434ad45a22b1d912fb01dae9448'
  })

  depends_on 'glibc' # R
  depends_on 'libuv'
  depends_on 'luajit'

  def self.patch
    system "sed -i 's,CMAKE_INSTALL_PREFIX}/lib,CMAKE_INSTALL_PREFIX}/#{ARCH_LIB},g' CMakeLists.txt"
  end

  cmake_options '-DBUILD_SHARED_LIBS=ON \
        -DWITH_SHARED_LIBUV=ON  \
        -DLUA_BUILD_TYPE=System \
        -DBUILD_MODULE=OFF'
end
