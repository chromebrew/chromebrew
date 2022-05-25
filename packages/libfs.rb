require 'package'

class Libfs < Package
  description 'X.org library interface to the X Font Server.'
  homepage 'http://www.x.org'
  license 'custom'
  version '1.0.9'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libFS-1.0.9.tar.xz'
  source_sha256 '597379438b3242ccc7d7b0fc432dc6c844eca0d4a82a7b82518bfeb203fc208a'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfs/1.0.9_armv7l/libfs-1.0.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfs/1.0.9_armv7l/libfs-1.0.9-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfs/1.0.9_i686/libfs-1.0.9-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfs/1.0.9_x86_64/libfs-1.0.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7f4159d023ced6bd8b42c5e398ce1a7876de0901077945e8dcdc0b8da1a15789',
     armv7l: '7f4159d023ced6bd8b42c5e398ce1a7876de0901077945e8dcdc0b8da1a15789',
       i686: 'af677f44f3b43f0a4e34ff2c5a45fd28738e9147d1208e8820d219530a33dab1',
     x86_64: '806e70356efb784e7e8be0c8ff0de277619c611a8ea2c76a11a74d7a53439d1c'
  })

  depends_on 'xorg_proto'
  depends_on 'libxtrans'
  depends_on 'glibc' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
