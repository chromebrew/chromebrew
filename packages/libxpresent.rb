require 'package'

class Libxpresent < Package
  description 'XPresent extension C library'
  homepage 'https://cgit.freedesktop.org/xorg/lib/libXpresent/'
  version '1.0.0'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/lib/libXpresent-1.0.0.tar.gz'
  source_sha256 '92f1bdfb67ae2ffcdb25ad72c02cac5e4912dc9bc792858240df1d7f105946fa'

  depends_on 'libxfixes'
  depends_on 'libxrandr'

  def self.build
      system "./configure #{CREW_OPTIONS} "
      system "make -j#{CREW_NPROC}"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end