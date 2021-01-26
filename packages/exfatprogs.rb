require 'package'

class Exfatprogs < Package
  description 'exFAT filesystem userspace utilities for the Linux Kernel exfat driver'
  homepage 'https://github.com/exfatprogs/exfatprogs'
  @_ver = '1.0.4'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/exfatprogs/exfatprogs/archive/#{@_ver}/exfatprogs-#{@_ver}.tar.gz"
  source_sha256 '3f755d35785a74138348b3a22dfcda5afc8a69e66a6a0c79be48225e6ca321ce'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/exfatprogs-1.0.4-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/exfatprogs-1.0.4-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/exfatprogs-1.0.4-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/exfatprogs-1.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '0fb0f5a16c09f11c912016a73d0002e252737106a3c2c31fd838b5057bee02b8',
      armv7l: '0fb0f5a16c09f11c912016a73d0002e252737106a3c2c31fd838b5057bee02b8',
        i686: 'ef85f1bae5f9079f7664509977c3dc9383c8427bc4109ca67162eb463d10048f',
      x86_64: '68184ee070d40c97c079fe6b5974e924ee373173b8c802d0c3f166d7277d70e7',
  })

  def self.build
    system './autogen.sh'
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      ./configure #{CREW_OPTIONS} --sbindir=#{CREW_PREFIX}/bin"
    system "make"
  end
  
  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    system "install -Dm644 -t #{CREW_DEST_PREFIX}/share/man/man8 */*.8"
  end
end
