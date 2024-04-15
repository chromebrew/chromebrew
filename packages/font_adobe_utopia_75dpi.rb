require 'package'

class Font_adobe_utopia_75dpi < Package
  description '100dpi Adobe Utopia PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.4'
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.x.org/releases/individual/font/font-adobe-utopia-75dpi-1.0.4.tar.bz2'
  source_sha256 '8732719c61f3661c8bad63804ebfd54fc7de21ab848e9a26a19b1778ef8b5c94'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'ee884c5a84f8ac67386a692ea8b67066d89474c11f856332c8d35b7a82d7a237',
     armv7l: 'ee884c5a84f8ac67386a692ea8b67066d89474c11f856332c8d35b7a82d7a237',
     x86_64: '8a3b3ac148eb5ebb421602ac50532db7969de14969cf0bd30c0714f30bcc0213'
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
