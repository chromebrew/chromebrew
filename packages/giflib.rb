require 'package'

class Giflib < Package
  description 'giflib is a library for reading and writing gif images.'
  homepage 'http://giflib.sourceforge.net/'
  version '5.1.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/giflib/giflib-5.1.4.tar.bz2'
  source_sha256 'df27ec3ff24671f80b29e6ab1c4971059c14ac3db95406884fc26574631ba8d5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/giflib/5.1.4_armv7l/giflib-5.1.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/giflib/5.1.4_armv7l/giflib-5.1.4-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/giflib/5.1.4_i686/giflib-5.1.4-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/giflib/5.1.4_x86_64/giflib-5.1.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '546af3350ca70ffc33ba0c12e6de65efe2fc9bce95ef3c48ab81da2d6cc1cae0',
     armv7l: '546af3350ca70ffc33ba0c12e6de65efe2fc9bce95ef3c48ab81da2d6cc1cae0',
       i686: 'ad9b824becceb46ad8b22515085ea105497117e10e7550f7ba965398c4d56d36',
     x86_64: '2efb3d4ac43bd4400e5af45cf8281e1852b86a2050af1efb0437eb9e92cd3312'
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking'
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
