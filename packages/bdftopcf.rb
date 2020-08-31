require 'package'

class Bdftopcf < Package
  description 'BDF to PCF font converter for X11'
  homepage 'https://xorg.freedesktop.org/'
  version '1.1'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/app/bdftopcf-1.1.tar.bz2'
  source_sha256 '4b4df05fc53f1e98993638d6f7e178d95b31745c4568cee407e167491fd311a2'

  depends_on 'libxfont'

  def self.build
      system "./configure #{CREW_OPTIONS} "
      system "make -j#{CREW_NPROC}"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
