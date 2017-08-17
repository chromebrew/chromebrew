require 'package'

class Mono < Package
  description 'Mono is a software platform designed to allow developers to easily create cross platform applications part of the .NET Foundation.'
  homepage 'http://www.mono-project.com/'
  version '5.4.0.135'
  source_url 'http://download.mono-project.com/sources/mono/mono-5.4.0.135.tar.bz2'
  source_sha256 '561af157ece41f0fc54dc3812bcbef6a04927274508104621b04fda810387ade'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mono-5.4.0.135-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mono-5.4.0.135-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mono-5.4.0.135-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mono-5.4.0.135-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3263b5b2db28850140e23e8819b555fdc93c6bfb445d66d94c75d0162c115223',
     armv7l: '3263b5b2db28850140e23e8819b555fdc93c6bfb445d66d94c75d0162c115223',
       i686: '81f11c2ca8e3f3685e8fe3c43debc257e2302f5dc82ef5269f87696bf515e12e',
     x86_64: 'b83170c8c162b8e1cd5ad3d1d4337448195757c54a1a733d6be3f7b2f5dd35f7',
  })

  def self.build
    system "./configure","--disable-dependency-tracking","--disable-silent-rules","--enable-nls=no","--prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
