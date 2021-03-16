require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library.'
  homepage 'http://libpng.org/pub/png/libpng.html'
  @_ver = '1.6.37'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/libpng/libpng16/#{@_ver}/libpng-#{@_ver}.tar.xz"
  source_sha256 '505e70834d35383537b6491e7ae8641f1a4bed1876dbfe361201fc80868d88ca'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.37-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.37-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.37-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.37-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'addb9158594a38f2d4ecd90c5de111d43586d3cdd9ab1edc25536cfb3dc3b760',
     armv7l: 'addb9158594a38f2d4ecd90c5de111d43586d3cdd9ab1edc25536cfb3dc3b760',
       i686: '865eea143c0e553d9aea22f20fb02cdb89d2fb823cbf94b1e79b1f3a1124442f',
     x86_64: '703cb00f75ecdab4918029aa57ee9ed53f027d0a4be6cd6c29b9e4fbd25f7dfe'
  })

  def self.patch
    system 'filefix'
  end

  def self.build
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --disable-dependency-tracking \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
