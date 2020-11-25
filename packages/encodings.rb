require 'package'

class Encodings < Package
  description 'X11 Font Index Generator'
  homepage 'https://xorg.freedesktop.org'
  version '1.0.5'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/encodings-1.0.5.tar.bz2'
  source_sha256 'bd96e16143a044b19e87f217cf6a3763a70c561d1076aad6f6d862ec41774a31'

  def self.build
      system "./configure #{CREW_OPTIONS} --with-fontrootdir=#{CREW_PREFIX}/share/fonts"
      system "sed -e 's|^\(encodings_DATA = $(DATA_FILES)\).*|\1|' -i Makefile" # Found in xbps-src  
      system 'make'
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
