# Adapted from Arch Linux glslang PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/glslang/trunk/PKGBUILD

require 'package'

class Glslang < Package
  description 'OpenGL and OpenGL ES shader front end and validator'
  version '8.13.3743'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/glslang/archive/8.13.3743.tar.gz'
  source_sha256 '639ebec56f1a7402f2fa094469a5ddea1eceecfaf2e9efe361376a0f73a7ee2f'

  depends_on 'python3'
  depends_on 'cmake' => ':build'
  depends_on 'ninja' => ':build'

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
