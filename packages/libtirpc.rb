require 'package'

class Libtirpc < Package
  description 'Libtirpc is a port of Suns Transport-Independent RPC library to Linux.'
  homepage 'https://sourceforge.net/projects/libtirpc'
  @_ver = '1.3.2'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url "http://downloads.sourceforge.net/project/libtirpc/libtirpc/#{@_ver}/libtirpc-#{@_ver}.tar.bz2"
  source_sha256 'e24eb88b8ce7db3b7ca6eb80115dd1284abc5ec32a8deccfed2224fc2532b9fd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtirpc/1.3.2_armv7l/libtirpc-1.3.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtirpc/1.3.2_armv7l/libtirpc-1.3.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtirpc/1.3.2_i686/libtirpc-1.3.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtirpc/1.3.2_x86_64/libtirpc-1.3.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3b96e0f200153be8e35a289d323d5465d4b11289d7e38bcc098a9c621e9ccf5d',
     armv7l: '3b96e0f200153be8e35a289d323d5465d4b11289d7e38bcc098a9c621e9ccf5d',
       i686: '19bf96ac7b5892c12237ee4bd57c8cb5e0bb6c68adaf2059d6a60ab143758241',
     x86_64: '8fffa00840f66ff4b6bb9c8d66a36d15208829fe2ff00dd0c46b435fcbc2201b'
  })

  depends_on 'e2fsprogs'

  def self.build
    system "./configure #{CREW_OPTIONS} #{CREW_ENV_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "mkdir #{CREW_DEST_PREFIX}/include/rpc"
    system "mv #{CREW_DEST_PREFIX}/include/tirpc/rpc/* #{CREW_DEST_PREFIX}/include/rpc/"
    system "curl -Lo #{CREW_DEST_PREFIX}/include/netconfig.h https://ftp.netbsd.org/pub/NetBSD/NetBSD-current/src/include/netconfig.h"
  end
end
