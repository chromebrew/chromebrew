require 'package'

class Libimagequant < Package
  description 'Library for high-quality conversion of RGBA images to 8-bit indexed-color palette images'
  homepage 'https://pngquant.org/lib/'
  @_ver = '2.14.1'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://github.com/ImageOptim/libimagequant/archive/#{@_ver}/libimagequant-#{@_ver}.tar.gz"
  source_sha256 'b5fa27da1f3cf3e8255dd02778bb6a51dc71ce9f99a4fc930ea69b83200a7c74'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libimagequant-2.14.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libimagequant-2.14.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libimagequant-2.14.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libimagequant-2.14.1-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0f7ae09c69f1648bf6a77c6d269336fa246c2415ff0cb0bb9fb2bb55c46edafe',
     armv7l: '0f7ae09c69f1648bf6a77c6d269336fa246c2415ff0cb0bb9fb2bb55c46edafe',
       i686: '74d2e1a73b3d45f33200a7f84b921ed459b51cb83ba4767d90657d939ab8df41',
     x86_64: '95a63c4b09e14a6c557bc4dfbced1414f1a07798dde25b1895bf5dfd1aae3223'
  })

  def self.build
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS} --with-openmp"
    system 'make all imagequant.pc'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} PREFIX=/usr install"
  end
end
