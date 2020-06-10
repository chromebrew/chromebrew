require 'package'

class Libsigcplusplus < Package
  description 'libsigc++ implements a typesafe callback system for standard C++.'
  homepage 'http://libsigc.sourceforge.net/'
  version '2.10.0'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/libsigc++/2.10/libsigc++-2.10.0.tar.xz'
  source_sha256 'f843d6346260bfcb4426259e314512b99e296e8ca241d771d21ac64f28298d81'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsigcplusplus-2.10.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsigcplusplus-2.10.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsigcplusplus-2.10.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsigcplusplus-2.10.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '526748e3a15fcd316fefc8c0359880b5c89640ad89a01de8c3f6210251e229f4',
     armv7l: '526748e3a15fcd316fefc8c0359880b5c89640ad89a01de8c3f6210251e229f4',
       i686: 'cbdf640dbf2462b3b8f24bb5f7cd2345f1ff3f46c983191e7ee31482213d24cd',
     x86_64: 'c32ff29b0f4a8394b69502cd3dc030848f84c5c3df048beb88966f7b1b6c6935',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
