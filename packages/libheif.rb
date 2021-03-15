require 'package'

class Libheif < Package
  description 'libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.'
  homepage 'https://github.com/strukturag/libheif'
  @_ver = '1.11.0'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://github.com/strukturag/libheif/releases/download/v#{@_ver}/libheif-#{@_ver}.tar.gz"
  source_sha256 'c550938f56ff6dac83702251a143f87cb3a6c71a50d8723955290832d9960913'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libheif-1.11.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libheif-1.11.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libheif-1.11.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libheif-1.11.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6541e90af54adca5af1a1c390fe6d9c48a5641e8a82e34fdd2aee4da48dae5fe',
     armv7l: '6541e90af54adca5af1a1c390fe6d9c48a5641e8a82e34fdd2aee4da48dae5fe',
       i686: '474eb4e10bdfd58bdd55d6cc0e60dcb964eda7c0038772d4a2e1b633642ab816',
     x86_64: '80496abc0efd38ce60d2a257e5f9d1b5095e291f8f37046dcf66462442f06714'
  })

  depends_on 'libde265'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libx265'
  depends_on 'libaom'
  depends_on 'dav1d'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system 'gdk-pixbuf-query-loaders --update-cache'
  end
end
