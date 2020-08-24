require 'package'

class Libxfce4util < Package
  description 'Utility library for the Xfce4 desktop environment'
  homepage 'https://xfce.org/'
  version '4.14.0'
  compatibility 'all'
  source_url 'https://archive.xfce.org/src/xfce/libxfce4util/4.14/libxfce4util-4.14.0.tar.bz2'
  source_sha256 '32ad79b7992ec3fd863e8ff2f03eebda8740363ef9d7d910a35963ac1c1a6324'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxfce4util-4.14.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxfce4util-4.14.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxfce4util-4.14.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxfce4util-4.14.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '06023cc89141955768a6c19ec1c9fa6c3c6944d6d0aee7d09007cb9eafdf0354',
     armv7l: '06023cc89141955768a6c19ec1c9fa6c3c6944d6d0aee7d09007cb9eafdf0354',
       i686: 'd53ff9b81ee9b2be8992ab2471af839f2ec7d7ab22f384bc6e356b9cc6e6a501',
     x86_64: 'f95cdc9a803db597e3996e4a21e430db51558c8b9b1a9b771e2baebedbc2bb8a',
  })

  depends_on 'gobject_introspection'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
