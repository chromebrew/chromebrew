require 'package'

class Devil < Package
  description 'Library for reading several different image formats'
  homepage 'http://openil.sourceforge.net/'
  version '1.8.0-e342'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/DentonW/DevIL/archive/e34284a7e07763769f671a74b4fec718174ad862.zip'
  source_sha256 '73728ff9f877b9247728ae46148866eea81092ccefb538a28640fe31b73d74ac'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/devil/1.8.0-e342_armv7l/devil-1.8.0-e342-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/devil/1.8.0-e342_armv7l/devil-1.8.0-e342-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/devil/1.8.0-e342_i686/devil-1.8.0-e342-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/devil/1.8.0-e342_x86_64/devil-1.8.0-e342-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7d45e28698eb99159d98b97760d11ddecff0ac87412b7cf249fb7e188b320502',
     armv7l: '7d45e28698eb99159d98b97760d11ddecff0ac87412b7cf249fb7e188b320502',
       i686: 'c75491427f9a75e33b8bca9f33b24cef15afc869118298d41177d45d3a913f4b',
     x86_64: '99de10866bec2ac80094d5f3ad8a4d906cb6597dd01a2cce7d408533488ce330'
  })

  depends_on 'freeglut'
  depends_on 'jasper'
  depends_on 'lcms'
  depends_on 'libglu'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libxi'
  depends_on 'libxmu'
  depends_on 'mesa'

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
