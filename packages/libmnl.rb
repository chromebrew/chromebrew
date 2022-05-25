require 'package'

class Libmnl < Package
  description 'libmnl is a minimalistic user-space library oriented to Netlink developers.'
  homepage 'https://www.netfilter.org/projects/libmnl/'
  version '1.0.5'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://www.netfilter.org/projects/libmnl/files/libmnl-1.0.5.tar.bz2'
  source_sha256 '274b9b919ef3152bfb3da3a13c950dd60d6e2bcd54230ffeca298d03b40d0525'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmnl/1.0.5_armv7l/libmnl-1.0.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmnl/1.0.5_armv7l/libmnl-1.0.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmnl/1.0.5_i686/libmnl-1.0.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmnl/1.0.5_x86_64/libmnl-1.0.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '85718120df283f822eeadce36b6db63f972ce349f09f1ec67dd15e0d3c9212ec',
     armv7l: '85718120df283f822eeadce36b6db63f972ce349f09f1ec67dd15e0d3c9212ec',
       i686: '248da767b3daea5332b311c12a4e092ffbd0615c38331bc1416809042e4190c4',
     x86_64: 'a791591c92ee92cb3d75ccb789e71f131395515004638eebb33664eb9ddb7e0a'
  })

  depends_on 'glibc' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
