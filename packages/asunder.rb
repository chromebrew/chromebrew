# Adapted from Arch Linux asunder PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/asunder/trunk/PKGBUILD

require 'package'

class Asunder < Package
  description 'a graphical CD ripper and encoder'
  homepage 'http://littlesvr.ca/asunder/'
  version '2.9.7'
  license 'GPL2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://littlesvr.ca/asunder/releases/asunder-2.9.7.tar.bz2'
  source_sha256 'c1c97cd34c04b8595e95df8a9a7dbc64a1e61f494b7a0cd2873802ad111874f4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4c004dfe3a8287cdb7f422bd808f7cead56bfaa496ec915e5dcb0f2816dad742',
     armv7l: '4c004dfe3a8287cdb7f422bd808f7cead56bfaa496ec915e5dcb0f2816dad742',
     x86_64: '46865361e0deeaef1539d52dc35daeb28c1b322b947a00a3b7c15580212ba686'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cdparanoia' # R
  depends_on 'freetype' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk2' # R
  depends_on 'harfbuzz' # R
  depends_on 'libcddb' # R
  depends_on 'pango' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
