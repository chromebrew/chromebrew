require 'package'

class Exo < Package
  description 'Extension library for the Xfce desktop environment'
  homepage 'https://xfce.org/'
  version '4.16.0'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/xfce/exo/4.16/exo-#{version}.tar.bz2"
  source_sha256 '1975b00eed9a8aa1f899eab2efaea593731c19138b83fdff2f13bdca5275bacc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/exo-4.16.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/exo-4.16.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/exo-4.16.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/exo-4.16.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f0320072faf16879bbd5dac3ccb130995a7a7240b18fea972ea4689c2355caf0',
     armv7l: 'f0320072faf16879bbd5dac3ccb130995a7a7240b18fea972ea4689c2355caf0',
       i686: 'ed48c7732a1b6ee48f1b8e3edf5c6eefc6799c53b13770eb0570ee2ce4c92e0a',
     x86_64: '8500a41e6e353f7a68e384d221085395c0cad4dcd2c9cc537b7b2dc01fd5bacc',
  })

  depends_on 'libxfce4ui'
  depends_on 'xfce4_dev_tools'

  def self.patch
    system "mkdir m4"
    system "NOCONFIGURE=1 xdt-autogen"
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
