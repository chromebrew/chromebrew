require 'package'

class Exo < Package
  description 'Extension library for the Xfce desktop environment'
  homepage 'https://xfce.org/'
  version '0.12.11'
  compatibility 'all'
  source_url 'https://archive.xfce.org/src/xfce/exo/0.12/exo-0.12.11.tar.bz2'
  source_sha256 'ec892519c08a67f3e0a1f0f8d43446e26871183e5aa6be7f82e214f388d1e5b6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/exo-0.12.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/exo-0.12.11-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/exo-0.12.11-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/exo-0.12.11-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '07177dc02a65d560e209dbe516aa38cd359b176689866e43e460d9269925b336',
     armv7l: '07177dc02a65d560e209dbe516aa38cd359b176689866e43e460d9269925b336',
       i686: 'ca69b4854fd2b219b04519b5f118b88afb0ba66362dbc2c0b4dcad39b051820b',
     x86_64: '9dba0db6d8e8253fc739b803aa604b2cc385d58af660e5b9c74332a9dae43075',
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
