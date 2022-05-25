require 'package'

class Libxcb < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.15'
  license 'custom'
  compatibility 'all'
  source_url 'https://xcb.freedesktop.org/dist/libxcb-1.15.tar.xz'
  source_sha256 'cc38744f817cf6814c847e2df37fcb8997357d72fa4bcbc228ae0fe47219a059'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxcb/1.15_armv7l/libxcb-1.15-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxcb/1.15_armv7l/libxcb-1.15-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxcb/1.15_i686/libxcb-1.15-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxcb/1.15_x86_64/libxcb-1.15-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fad951d000d7d85249abf783489d84f1d34a938cb10cd29ca7c891b9b5657767',
     armv7l: 'fad951d000d7d85249abf783489d84f1d34a938cb10cd29ca7c891b9b5657767',
       i686: 'cc9c9c2c023c4aa478f0b256f5e4aa3b3fa51b36d8f94627342c4f2f6ca1bbbf',
     x86_64: 'd1e81462049e32ba54bedf4a3d6ce39cb8610fa3d9b451618a78446b625fd564'
  })

  depends_on 'xcb_proto'
  depends_on 'libxau'
  depends_on 'pthread_stubs'
  depends_on 'glibc' # R
  depends_on 'libxdmcp' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R

  def self.build
    system 'filefix'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
        --enable-dri3 \
        --disable-xevie \
        --disable-devel-docs"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
