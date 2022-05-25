# Adapted from Arch Linux libluv PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libluv/trunk/PKGBUILD

require 'package'

class Libluv < Package
  description 'Bare libuv bindings for lua'
  homepage 'https://github.com/luvit/luv'
  version '1.44.2'
  license 'apache'
  compatibility 'all'
  source_url 'https://github.com/luvit/luv.git'
  git_hashtag '1.44.2-0'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libluv/1.44.2_armv7l/libluv-1.44.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libluv/1.44.2_armv7l/libluv-1.44.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libluv/1.44.2_i686/libluv-1.44.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libluv/1.44.2_x86_64/libluv-1.44.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c0f550aad24be7f0845fbb730a70dad758a624deaf7e4bf8d1b4446cd4e3fcd1',
     armv7l: 'c0f550aad24be7f0845fbb730a70dad758a624deaf7e4bf8d1b4446cd4e3fcd1',
       i686: '3622475bd90dbc8942dd9b4a9249e2d0e7e1a03b837b8a983d7cec309f344742',
     x86_64: 'd3d7f404503c1bda84471ff8ae47c10312f89940bed310d220fb8dbdb7fb2fca'
  })

  depends_on 'luajit'
  depends_on 'libuv'

  def self.patch
    system "sed -i 's,CMAKE_INSTALL_PREFIX}/lib,CMAKE_INSTALL_PREFIX}/#{ARCH_LIB},g' CMakeLists.txt"
  end

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS} \
        -DBUILD_SHARED_LIBS=ON \
        -DWITH_SHARED_LIBUV=ON  \
        -DLUA_BUILD_TYPE=System \
        -DBUILD_MODULE=OFF \
        ../ -G Ninja"
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
