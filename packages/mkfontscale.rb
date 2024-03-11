require 'package'

class Mkfontscale < Package
  description 'X11 Scalable Font Index Generator'
  homepage 'https://www.x.org/wiki'
  version '1.2.1-1'
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.x.org/releases/individual/app/mkfontscale-1.2.1.tar.bz2'
  source_sha256 'ca0495eb974a179dd742bfa6199d561bda1c8da4a0c5a667f21fd82aaab6bac7'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '6dc86c623685bdc66affcdf10ddf98f0c3d0a1426e68556eb5b3eb88a238c868',
     armv7l: '6dc86c623685bdc66affcdf10ddf98f0c3d0a1426e68556eb5b3eb88a238c868',
     x86_64: '3c30b109c94cba6d833ad87644e01daba2a78a6954cea5d9b7749f569cd5bcac'
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
