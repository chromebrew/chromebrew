require 'package'

class Xinit < Package
  description 'The xinit package contains a usable script to start the xserver.'
  homepage 'https://www.x.org'
  version '1.4.0-1'
  compatibility 'all'
  source_url 'https://x.org/pub/individual/app/xinit-1.4.0.tar.bz2'
  source_sha256 '230835eef2f5978a1e1344928168119373f6df1d0a32c09515e545721ee582ef'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xinit-1.4.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xinit-1.4.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xinit-1.4.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xinit-1.4.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '571b3b0688bb7013a186dc577d6a6ea5b036f08b398a42528512c8990b03f51b',
     armv7l: '571b3b0688bb7013a186dc577d6a6ea5b036f08b398a42528512c8990b03f51b',
       i686: '3feebdbc9b9138d8acc6cfcf36459581f6bae6e8e8f26fdbcf6945f66c66743c',
     x86_64: '943fd77aebd9dc370ca8ba637493e39d4e92e018dcea4b03a0d69566be64cb34',
  })

  depends_on 'twm'
  depends_on 'xauth'
  depends_on 'xclock'
  depends_on 'xterm'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
