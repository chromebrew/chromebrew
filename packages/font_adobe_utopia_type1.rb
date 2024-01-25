require 'package'

class Font_adobe_utopia_type1 < Package
  description 'Adobe Utopia Type1 fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.4'
  license 'custom'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-adobe-utopia-type1-1.0.4.tar.bz2'
  source_sha256 '979435105f897a70f8993fa02c8362160b0513366c2ab896965416f96dbb8077'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '2e0f5a41d6d0d01abc90e1646315c027489fb53c662d6885e7b729449107d94b',
     armv7l: '2e0f5a41d6d0d01abc90e1646315c027489fb53c662d6885e7b729449107d94b',
       i686: '6e5ab58840dfac86b37565200dbff84d6e9baed00b0adca72268c1afdf3eaeba',
     x86_64: '78465e87c0964dff80de20039762822063fe56273c5a83f3170c1e84d4b76d2f'
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
