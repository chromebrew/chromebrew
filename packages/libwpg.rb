# Adapted from Arch Linux libwpg PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libwpg/trunk/PKGBUILD

require 'package'

class Libwpg < Package
  description 'Library for importing and converting Corel WordPerfecttm Graphics images.'
  homepage 'https://libwpg.sourceforge.net/'
  version '0.3.3'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/libwpg/libwpg-0.3.3.tar.xz'
  source_sha256 '99b3f7f8832385748582ab8130fbb9e5607bd5179bebf9751ac1d51a53099d1c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '645138bbef5bc5d36a2f5f91c59f9163078ef9044d127a27fe257449eec45f5e',
     armv7l: '645138bbef5bc5d36a2f5f91c59f9163078ef9044d127a27fe257449eec45f5e',
       i686: 'b187f519dc386f57aad39c01947be79e64c6ff8b3d7d4aaea7956b7f4ec125a0',
     x86_64: '9b7f4b5b3e31bd451a7c80d895490c784517f29d2b5f3126e7abf332e4ab4a21'
  })

  depends_on 'doxygen' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'librevenge' # R
  depends_on 'libwpd' # R
  depends_on 'perl' => :build
  depends_on 'zlibpkg' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
