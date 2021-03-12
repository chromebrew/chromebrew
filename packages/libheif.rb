require 'package'

class Libheif < Package
  description 'libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.'
  homepage 'https://github.com/strukturag/libheif'
  @_ver = '1.11.0'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/strukturag/libheif/releases/download/v#{@_ver}/libheif-#{@_ver}.tar.gz"
  source_sha256 'c550938f56ff6dac83702251a143f87cb3a6c71a50d8723955290832d9960913'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libheif-1.11.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libheif-1.11.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libheif-1.11.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libheif-1.11.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6895e7a1367487e59d771e82498f9f4c6c1c0408099e878716e40ebc27bb2cc6',
     armv7l: '6895e7a1367487e59d771e82498f9f4c6c1c0408099e878716e40ebc27bb2cc6',
       i686: '570e56cbe7ad4ed99872cd8e12f2e461d103e9fcb6c8b942c798e14dca2d484a',
     x86_64: '28fccd530636486eadbc579ce29b6d25ab5e86355e891d070cc485f606dc8f18'
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
