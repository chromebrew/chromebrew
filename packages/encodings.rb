require 'package'

class Encodings < Package
  description 'X11 Font Index Generator'
  homepage 'https://xorg.freedesktop.org'
  version '1.0.5'
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.x.org/releases/individual/font/encodings-1.0.5.tar.bz2'
  source_sha256 'bd96e16143a044b19e87f217cf6a3763a70c561d1076aad6f6d862ec41774a31'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'eaa062b2b7fb598e9f08c6c3a17cac90d216af00da3a53d345fa1c9b25acf00c',
     armv7l: 'eaa062b2b7fb598e9f08c6c3a17cac90d216af00da3a53d345fa1c9b25acf00c',
     x86_64: '7571507bb292543e9a4fabb77eb51713403983c04bab5b5b1593946f4a07a00a'
  })

  depends_on 'mkfontscale'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-fontrootdir=#{CREW_PREFIX}/share/fonts"
    system "sed -e 's|^\(encodings_DATA = $(DATA_FILES)\).*|\1|' -i Makefile" # Found in xbps-src
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
