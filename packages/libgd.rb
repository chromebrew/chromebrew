require 'package'

class Libgd < Package
  description 'GD is an open source code library for the dynamic creation of images by programmers.'
  homepage 'https://libgd.github.io/'
  @_ver = '2.3.2'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/libgd/libgd/archive/gd-#{@_ver}.tar.gz"
  source_sha256 'dcc22244d775f469bee21dce1ea42552adbb72ba0cc423f9fa6a64601b3a1893'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgd-2.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgd-2.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgd-2.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgd-2.3.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'af41a2f68397421ae6d8974b1caaf41e559ddfce9b381dfa45ad235b8f912f1c',
     armv7l: 'af41a2f68397421ae6d8974b1caaf41e559ddfce9b381dfa45ad235b8f912f1c',
       i686: 'd6a56c32366bb5014e5cf04bd7a0ad4e9eb0038bb95df2e2ec7793d67111e4bc',
     x86_64: '41a0e61d953cca647d9a31bf88c294918f7f089689f3552fb93cf2903aadeabe'
  })

  depends_on 'libpng'
  depends_on 'libavif'
  depends_on 'libheif'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -I#{CREW_PREFIX}/include/harfbuzz' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DCMAKE_INCLUDE_PATH=#{CREW_PREFIX}/include \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
