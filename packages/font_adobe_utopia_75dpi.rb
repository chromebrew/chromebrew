require 'package'

class Font_adobe_utopia_75dpi < Package
  description '100dpi Adobe Utopia PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.4'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-adobe-utopia-75dpi-1.0.4.tar.bz2'
  source_sha256 '8732719c61f3661c8bad63804ebfd54fc7de21ab848e9a26a19b1778ef8b5c94'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/font_adobe_utopia_75dpi-1.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/font_adobe_utopia_75dpi-1.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/font_adobe_utopia_75dpi-1.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/font_adobe_utopia_75dpi-1.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ee884c5a84f8ac67386a692ea8b67066d89474c11f856332c8d35b7a82d7a237',
     armv7l: 'ee884c5a84f8ac67386a692ea8b67066d89474c11f856332c8d35b7a82d7a237',
       i686: '0c5cd71a68340ed2adc6632c36f5b856ca83b71a818f67495142da39abd1c84a',
     x86_64: '8a3b3ac148eb5ebb421602ac50532db7969de14969cf0bd30c0714f30bcc0213',
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
