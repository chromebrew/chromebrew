require 'package'

class Libmpeg2 < Package
  description 'A free MPEG-2 video stream decoder'
  homepage 'https://libmpeg2.sourceforge.io/'
  version '0.5.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://libmpeg2.sourceforge.io/files/libmpeg2-0.5.1.tar.gz'
  source_sha256 'dee22e893cb5fc2b2b6ebd60b88478ab8556cb3b93f9a0d7ce8f3b61851871d4'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmpeg2/0.5.1_armv7l/libmpeg2-0.5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmpeg2/0.5.1_armv7l/libmpeg2-0.5.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmpeg2/0.5.1_i686/libmpeg2-0.5.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmpeg2/0.5.1_x86_64/libmpeg2-0.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '721c1ed49bedf3cbf0f60b5c282e4d5cbed478a958523bdb69dd9072ab8249c7',
     armv7l: '721c1ed49bedf3cbf0f60b5c282e4d5cbed478a958523bdb69dd9072ab8249c7',
       i686: '78c9181eb32d615797d7d2f77ddf047479780e1fab5c0770ad78e295408ca668',
     x86_64: '41d4b5267d89ee3783d23b9c8684ba711e275a598b48db906dfb1c90bc10cd0c',
  })

  depends_on 'libx11'
  depends_on 'imake' => :build

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --with-x"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
