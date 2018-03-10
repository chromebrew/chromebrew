require 'package'

class Libwacom < Package
  description 'libwacom is a wrapper library for evdev devices.'
  homepage 'http://linuxwacom.sourceforge.net/wiki/index.php/Libwacom'
  version '0.28-0'
  source_url 'https://downloads.sourceforge.net/linuxwacom/libwacom-0.28.tar.bz2'
  source_sha256 'e7d632301288b221cb5af69b4c5e57fd062bafd9a9acd6f9ce271570103267ef'

  depends_on 'libgudev'
  depends_on 'eudev'
       
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
