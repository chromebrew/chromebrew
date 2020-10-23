# Adapted from Arch Linux glslang PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/glslang/trunk/PKGBUILD

require 'package'

class Glslang < Package
  description 'OpenGL and OpenGL ES shader front end and validator'
  version '8.13.3743'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/glslang/archive/8.13.3743.tar.gz'
  source_sha256 '639ebec56f1a7402f2fa094469a5ddea1eceecfaf2e9efe361376a0f73a7ee2f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glslang-8.13.3743-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glslang-8.13.3743-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glslang-8.13.3743-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glslang-8.13.3743-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '927f23fc3390cc2b66da76f8ebab2ed55e04c2544d8ed5ce3ce84f734d6631d6',
     armv7l: '927f23fc3390cc2b66da76f8ebab2ed55e04c2544d8ed5ce3ce84f734d6631d6',
       i686: '73a6dd675301d314921c69f016659cfe1c520176ece194eac6e47b934706b213',
     x86_64: '51de97dab57fb0e21f4b0746b1117cca66481d8dfe63065edda8f122feaceb6f',
  })

  def self.build
    system "./update_glslang_sources.py"
    
    Dir.mkdir 'build-shared'
    Dir.chdir 'build-shared' do
      system "cmake .. \
      -GNinja \
      -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
      -DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX} \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON"
    end
    system 'ninja -C build-shared'
    
    Dir.mkdir 'build-static'
    Dir.chdir 'build-static' do
    system "cmake .. \
      -GNinja \
      -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
      -DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX} \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=OFF"
      end
    system 'ninja -C build-static'
  end

  def self.install
  system "DESTDIR=#{CREW_DEST_DIR} ninja -C build-shared install"
  system "DESTDIR=#{CREW_DEST_DIR} ninja -C build-static install"
  end
end
