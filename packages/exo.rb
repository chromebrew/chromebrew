require 'package'

class Exo < Package
  description 'Extension library for the Xfce desktop environment'
  homepage 'https://xfce.org/'
  version '4.16.0'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/xfce/exo/4.16/exo-#{version}.tar.bz2"
  source_sha256 '1975b00eed9a8aa1f899eab2efaea593731c19138b83fdff2f13bdca5275bacc'

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
