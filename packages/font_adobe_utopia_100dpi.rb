require 'package'

class Font_adobe_utopia_100dpi < Package
  description '100dpi Adobe Utopia PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.4'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-adobe-utopia-100dpi-1.0.4.tar.bz2'
  source_sha256 'd16f5e3f227cc6dd07a160a71f443559682dbc35f1c056a5385085aaec4fada5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/font_adobe_utopia_100dpi-1.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/font_adobe_utopia_100dpi-1.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/font_adobe_utopia_100dpi-1.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/font_adobe_utopia_100dpi-1.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c217c619266885a4d3d2860ab9f0a4376590c75609db41ac2f4ff0bfc90bffed',
     armv7l: 'c217c619266885a4d3d2860ab9f0a4376590c75609db41ac2f4ff0bfc90bffed',
       i686: '88d1fc4761c703b059669aea4ba713b1df82997d63c3b4c2dbee89fbf12c6522',
     x86_64: '513463f01f5bee4f268e0bb264748252936273c8c5c5a37e1d28a2b54a66480d',
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
