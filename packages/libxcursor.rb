require 'package'

class Libxcursor < Package
  description 'X.org X Cursor management library'
  homepage 'http://www.x.org'
  @_ver = '1.2.0'
  version @_ver
  compatibility 'all'
  source_url "https://www.x.org/archive/individual/lib/libXcursor-#{@_ver}.tar.gz"
  source_sha256 'ad5b2574fccaa4c3fa67b9874fbed863d29ad230c784e9a08b20692418f6a1f8'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcursor-1.2.0-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxcursor-1.2.0-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxcursor-1.2.0-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcursor-1.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'e605f3d58857df9ccdf5abdc8e9b3c16b8f424953406fb04585741504cb443bf',
      armv7l: 'e605f3d58857df9ccdf5abdc8e9b3c16b8f424953406fb04585741504cb443bf',
        i686: '8c91e2a04ee4749324447217d5da5981275a6d847c691aebe74ca96bb791fe33',
      x86_64: 'bc4900d480ea5e94ded6b4b81c9a45a41216b977754ab3cfa5a0862bb02c2279',
  })

  depends_on 'libxrender'
  depends_on 'libxfixes'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
