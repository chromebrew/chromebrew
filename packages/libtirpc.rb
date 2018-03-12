require 'package'

class Libtirpc < Package
  description 'Libtirpc is a port of Suns Transport-Independent RPC library to Linux.'
  homepage 'https://sourceforge.net/projects/libtirpc'
  version '1.0.2'
  source_url 'http://downloads.sourceforge.net/project/libtirpc/libtirpc/1.0.2/libtirpc-1.0.2.tar.bz2'
  source_sha256 '723c5ce92706cbb601a8db09110df1b4b69391643158f20ff587e20e7c5f90f5'

  binary_url ({

  })
  binary_sha256 ({

  })

  depends_on 'krb5'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir #{CREW_DEST_DIR}/usr/local/include/rpc"
    system "mv #{CREW_DEST_DIR}/usr/local/include/tirpc/rpc/* #{CREW_DEST_DIR}/usr/local/include/rpc/"
    
    system "curl -Lo #{CREW_DEST_DIR}/usr/local/include/netconfig.h https://ftp.netbsd.org/pub/NetBSD/NetBSD-current/src/include/netconfig.h"
  end
end
