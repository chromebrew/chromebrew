require 'package'

class Exo < Package
  description 'Extension library for the Xfce desktop environment'
  homepage "https://xfce.org/"
  version '0.12.11'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/xfce/exo/0.12/exo-0.12.11.tar.bz2"
  source_sha256 'ec892519c08a67f3e0a1f0f8d43446e26871183e5aa6be7f82e214f388d1e5b6'
    
  depends_on 'xfce4_dev_tools'
  depends_on 'libxfce4ui'

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
