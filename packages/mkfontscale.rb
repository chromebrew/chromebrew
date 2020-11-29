require 'package'

class Mkfontscale < Package
  description 'X11 Scalable Font Index Generator'
  homepage 'https://www.x.org/wiki'
  version '1.2.1-1'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/app/mkfontscale-1.2.1.tar.bz2'
  source_sha256 'ca0495eb974a179dd742bfa6199d561bda1c8da4a0c5a667f21fd82aaab6bac7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mkfontscale-1.2.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mkfontscale-1.2.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mkfontscale-1.2.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mkfontscale-1.2.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6dc86c623685bdc66affcdf10ddf98f0c3d0a1426e68556eb5b3eb88a238c868',
     armv7l: '6dc86c623685bdc66affcdf10ddf98f0c3d0a1426e68556eb5b3eb88a238c868',
       i686: 'e8c657ed8473ecb36340e2c70429a27f864e29f408602e62bbdb35e7c7831ab0',
     x86_64: '3c30b109c94cba6d833ad87644e01daba2a78a6954cea5d9b7749f569cd5bcac',
  })

  depends_on 'xorg_proto'
  depends_on 'freetype'
  depends_on 'libfontenc'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
