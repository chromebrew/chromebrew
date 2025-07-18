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
    aarch64: 'c0f550aad24be7f0845fbb730a70dad758a624deaf7e4bf8d1b4446cd4e3fcd1',
     armv7l: 'c0f550aad24be7f0845fbb730a70dad758a624deaf7e4bf8d1b4446cd4e3fcd1',
       i686: '3622475bd90dbc8942dd9b4a9249e2d0e7e1a03b837b8a983d7cec309f344742',
     x86_64: 'd3d7f404503c1bda84471ff8ae47c10312f89940bed310d220fb8dbdb7fb2fca'
  })

  depends_on 'luajit'
  depends_on 'libuv'
  depends_on 'glibc' # R

  def self.patch
    system "sed -i 's,CMAKE_INSTALL_PREFIX}/lib,CMAKE_INSTALL_PREFIX}/#{ARCH_LIB},g' CMakeLists.txt"
  end

  cmake_options '-DBUILD_SHARED_LIBS=ON \
        -DWITH_SHARED_LIBUV=ON  \
        -DLUA_BUILD_TYPE=System \
        -DBUILD_MODULE=OFF'
end
