require 'package'

class Xorg_cf_files < Package
  description 'X.org cf files for use with imake builds.'
  homepage 'https://x.org'
  version '1.0.6-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/util/xorg-cf-files-1.0.6.tar.gz'
  source_sha256 '6d56094e5d1a6c7d7a9576ac3a0fc2c042344509ea900d59f4b23df668b96c7a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_cf_files/1.0.7_armv7l/xorg_cf_files-1.0.7-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_cf_files/1.0.7_armv7l/xorg_cf_files-1.0.7-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_cf_files/1.0.6-1_i686/xorg_cf_files-1.0.6-1-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_cf_files/1.0.6-1_x86_64/xorg_cf_files-1.0.6-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '33f293b55cd416e2bd7be8658f1c1a19187d99e8e043ccb1aa42d5c8284fc8d0',
     armv7l: '33f293b55cd416e2bd7be8658f1c1a19187d99e8e043ccb1aa42d5c8284fc8d0',
    i686: 'd0360fd8c1db9eac92973e4a311fcb804476a5c581deb11e5b1cbe41af0a42b2',
  x86_64: '8c8286394588d83387cb89afd5f687e84fd2e61a2d23d088176e60dc3d869b25'
  })

  depends_on 'font_util'

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
