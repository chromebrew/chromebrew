require 'package'

class Font_bh_type1 < Package
  description 'Standard Bigelow and Holmes Type1 fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  license 'bh-luxi'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-bh-type1-1.0.3.tar.bz2'
  source_sha256 '761455a297486f3927a85d919b5c948d1d324181d4bea6c95d542504b68a63c1'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/font_bh_type1/1.0.3_armv7l/font_bh_type1-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/font_bh_type1/1.0.3_armv7l/font_bh_type1-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/font_bh_type1/1.0.3_i686/font_bh_type1-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/font_bh_type1/1.0.3_x86_64/font_bh_type1-1.0.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5d8fdfff994102c3a4a801112f7dd9d6e310f604c477d1b2cb17ecde1e42a0ab',
     armv7l: '5d8fdfff994102c3a4a801112f7dd9d6e310f604c477d1b2cb17ecde1e42a0ab',
       i686: '2235b52c55a958b30126bc5318f32386d684e957a332a4e0f424eb8da2ff0c21',
     x86_64: '7cb22c07fb43982d548a0fd3801f426e8cbbb4f5cdd037c213060a58295ec512'
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
