# Adapted from Arch Linux msgpack-c PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/msgpack-c/trunk/PKGBUILD

require 'package'

class Msgpack_c < Package
  description 'An efficient object serialization library'
  homepage 'https://msgpack.org/'
  version '4.0.0'
  license 'custom:Boost'
  compatibility 'all'
  source_url 'https://github.com/msgpack/msgpack-c/releases/download/c-4.0.0/msgpack-c-4.0.0.tar.gz'
  source_sha256 '420fe35e7572f2a168d17e660ef981a589c9cbe77faa25eb34a520e1fcc032c8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6f135003a98c4c33e936257a416166187753d66618c8663176e60950314bbffd',
     armv7l: '6f135003a98c4c33e936257a416166187753d66618c8663176e60950314bbffd',
       i686: '54e7a62e5a889d34046131de43601a41762ce54fdc90751043e4b8bb4a3e8fdf',
     x86_64: 'c4ce44f936fa4f393446b3193aca6cf911d23fc95c409a5d02ba500afe36706c'
  })

  depends_on 'cmake' => :build
  depends_on 'doxygen' => :build
  depends_on 'graphviz' => :build

  def self.patch
    system "sed -i 's,exec_prefix}/lib,exec_prefix}/#{ARCH_LIB},g' CMakeLists.txt"
    system "sed -i 's,CMAKE_INSTALL_PREFIX}/lib,CMAKE_INSTALL_PREFIX}/#{ARCH_LIB},g' CMakeLists.txt"
    system "sed -i 's,CMAKE_INSTALL_LIBDIR lib,CMAKE_INSTALL_LIBDIR #{ARCH_LIB},g' CMakeLists.txt"
  end

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS} \
      -DCMAKE_C_STANDARD='17' \
      -DBUILD_SHARED_LIBS=ON \
      -DMSGPACK_ENABLE_STATIC=OFF \
      -DMSGPACK_BUILD_EXAMPLES=OFF \
      -DMSGPACK_BUILD_TESTS=OFF \
      ../ -G Ninja"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
