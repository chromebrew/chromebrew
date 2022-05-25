require 'package'

class Font_adobe_100dpi < Package
  description 'Standard 100dpi Adobe PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  license 'custom'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-adobe-100dpi-1.0.3.tar.bz2'
  source_sha256 'b2c08433eab5cb202470aa9f779efefce8d9cab2534f34f3aa4a31d05671c054'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/font_adobe_100dpi/1.0.3_armv7l/font_adobe_100dpi-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/font_adobe_100dpi/1.0.3_armv7l/font_adobe_100dpi-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/font_adobe_100dpi/1.0.3_i686/font_adobe_100dpi-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/font_adobe_100dpi/1.0.3_x86_64/font_adobe_100dpi-1.0.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'bd1f009f3db17d73db401bcfdddca3f8471b29e2d387569aabe9d5ffc000a8df',
     armv7l: 'bd1f009f3db17d73db401bcfdddca3f8471b29e2d387569aabe9d5ffc000a8df',
       i686: 'a472e463432ad5a82c4e1362f96fa406c25640308c646a258342b8e9d04f891e',
     x86_64: 'b682ca853cb284f521969cd47683b21ae55089014d9408980b5c4d9e6b5c1e35'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-fontrootdir=#{CREW_PREFIX}/share/fonts"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
