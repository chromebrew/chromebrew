require 'package'

class Devil < Package
  description 'Library for reading several different image formats'
  homepage 'http://openil.sourceforge.net/'
  version '1.8.0-e342'
  compatibility 'all'
  source_url 'https://github.com/DentonW/DevIL/archive/e34284a7e07763769f671a74b4fec718174ad862.zip'
  source_sha256 '73728ff9f877b9247728ae46148866eea81092ccefb538a28640fe31b73d74ac'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/devil-1.8.0-e342-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/devil-1.8.0-e342-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/devil-1.8.0-e342-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/devil-1.8.0-e342-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b20edfe23152ce8c1de0dc78ce1098dc5844ba23377108f93c5222101099c51c',
     armv7l: 'b20edfe23152ce8c1de0dc78ce1098dc5844ba23377108f93c5222101099c51c',
       i686: 'cd64e331c519a10550c774af9d9c304fa80811d482304e5889f3d0d6136489c8',
     x86_64: '1762d8d08c4d21a8b892864e2d18871b2f15a99a59a543faa42682e7921293f7'
  })

  depends_on 'libpng'
  depends_on 'jasper'
  depends_on 'lcms'
  depends_on 'libjpeg_turbo'

  def self.patch
    system "find -type f -exec sed -i 's,DESTINATION lib,DESTINATION lib#{CREW_LIB_SUFFIX},g' {} +"
  end

  def self.build
    Dir.mkdir 'DevIL/builddir'
    Dir.chdir 'DevIL/builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -I#{CREW_PREFIX}/include/harfbuzz' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS.sub(/--build=.*/, '')} \
        -DBUILD_SHARED_LIBS=ON \
        .."
    end
    system 'ninja -C DevIL/builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C DevIL/builddir install"
  end
end
