require 'package'

class Libtirpc < Package
  description 'Libtirpc is a port of Suns Transport-Independent RPC library to Linux.'
  homepage 'https://sourceforge.net/projects/libtirpc'
  version '1.0.2-0'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/project/libtirpc/libtirpc/1.0.2/libtirpc-1.0.2.tar.bz2'
  source_sha256 '723c5ce92706cbb601a8db09110df1b4b69391643158f20ff587e20e7c5f90f5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.0.2-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.0.2-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.0.2-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.0.2-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f2af84d80968a7b7271d7ed00e9fa771157530a237282c9c0cea0eea39fea167',
     armv7l: 'f2af84d80968a7b7271d7ed00e9fa771157530a237282c9c0cea0eea39fea167',
       i686: '3f484468cba8c5e69bff19eaa5c326dbb7e2e44d7e41c1c7ce3f570d0a7eb526',
     x86_64: '6d4a7b558189ac4b78c24f6d5aa5904ed2dfe960ff3a6b1a4019294e2c051fc7',
  })

  depends_on 'krb5'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir #{CREW_DEST_PREFIX}/include/rpc"
    system "mv #{CREW_DEST_PREFIX}/include/tirpc/rpc/* #{CREW_DEST_PREFIX}/include/rpc/"
    system "curl -Lo #{CREW_DEST_PREFIX}/include/netconfig.h https://ftp.netbsd.org/pub/NetBSD/NetBSD-current/src/include/netconfig.h"
  end
end
