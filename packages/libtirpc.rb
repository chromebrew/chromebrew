require 'package'

class Libtirpc < Package
  description 'Libtirpc is a port of Suns Transport-Independent RPC library to Linux.'
  homepage 'https://sourceforge.net/projects/libtirpc'
  version '1.0.2'
  source_url 'http://downloads.sourceforge.net/project/libtirpc/libtirpc/1.0.2/libtirpc-1.0.2.tar.bz2'
  source_sha256 '723c5ce92706cbb601a8db09110df1b4b69391643158f20ff587e20e7c5f90f5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.0.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.0.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0de6310280dc7845637976ea042bc9bc608fab9569e6fed8a429db12015a0737',
     armv7l: '0de6310280dc7845637976ea042bc9bc608fab9569e6fed8a429db12015a0737',
       i686: '11eaa0ef23ed9fd214a4c3aa87fd4a642bf00a6d597bf177185a29e1d52749ca',
     x86_64: '3465e356fbdb29c63383062a58e62e8f9dd8a297a3c1706f82f846636d5dc303',
  })

  depends_on 'krb5'
  
  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir #{CREW_DEST_DIR}/usr/local/include/rpc"
    system "mv #{CREW_DEST_DIR}/usr/local/include/tirpc/rpc/* #{CREW_DEST_DIR}/usr/local/include/rpc/"
    
    system "curl -Lo #{CREW_DEST_DIR}/usr/local/include/netconfig.h https://ftp.netbsd.org/pub/NetBSD/NetBSD-current/src/include/netconfig.h"
  end
end
