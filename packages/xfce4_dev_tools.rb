require 'package'

class Xfce4_dev_tools < Package
  description 'Xfce4 development tools'
  homepage "https://xfce.org/"
  version '4.14.0'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/xfce/xfce4-dev-tools/4.14/xfce4-dev-tools-4.14.0.tar.bz2"
  source_sha256 '2c9eb8e0fe23e47dc31411a93b683fd1b7a49140e9163f0aab9e94a3d8a0b5fd'
    
  depends_on 'gtk_doc'

  def self.build
      system "./configure #{CREW_OPTIONS}"
      system "make -j#{CREW_NPROC}"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
