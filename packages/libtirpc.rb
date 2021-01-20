require 'package'

class Libtirpc < Package
  description 'Libtirpc is a port of Suns Transport-Independent RPC library to Linux.'
  homepage 'https://sourceforge.net/projects/libtirpc'
  @_ver = '1.3.1'
  version @_ver
  compatibility 'all'
  source_url "http://downloads.sourceforge.net/project/libtirpc/libtirpc/#{@_ver}/libtirpc-#{@_ver}.tar.bz2"
  source_sha256 '245895caf066bec5e3d4375942c8cb4366adad184c29c618d97f724ea309ee17'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.3.1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.3.1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.3.1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '489870e43cd86ca9aa252f3639f54e8af9bc6b33e16ef96aa66f0114bef8ee90',
      armv7l: '489870e43cd86ca9aa252f3639f54e8af9bc6b33e16ef96aa66f0114bef8ee90',
        i686: '987de099b04760d251425554071d505ec001818a152a782cd51b92ae6edf9dc5',
      x86_64: '982db8c305a1c2859ab9954a18e03e5500a277fa00717e7646bf69b95a744213',
  })

  depends_on 'krb5'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir #{CREW_DEST_PREFIX}/include/rpc"
    system "mv #{CREW_DEST_PREFIX}/include/tirpc/rpc/* #{CREW_DEST_PREFIX}/include/rpc/"
    system "curl -Lo #{CREW_DEST_PREFIX}/include/netconfig.h https://ftp.netbsd.org/pub/NetBSD/NetBSD-current/src/include/netconfig.h"
  end
end
