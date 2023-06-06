# Adapted from Arch Linux librevenge PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/librevenge/trunk/PKGBUILD

require 'package'

class Librevenge < Package
  description 'library for REVerses ENGineered formats filters'
  homepage 'https://sf.net/p/libwpd/librevenge/'
  version '0.0.5'
  license 'MPL'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/libwpd/files/librevenge/librevenge-0.0.5/librevenge-0.0.5.tar.xz'
  source_sha256 '106d0c44bb6408b1348b9e0465666fa83b816177665a22cd017e886c1aaeeb34'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librevenge/0.0.5_armv7l/librevenge-0.0.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librevenge/0.0.5_armv7l/librevenge-0.0.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librevenge/0.0.5_i686/librevenge-0.0.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librevenge/0.0.5_x86_64/librevenge-0.0.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'aec34f24effeb65bf094668a143ee8137620ced6b2b52a36a6c95ec65dddb98f',
     armv7l: 'aec34f24effeb65bf094668a143ee8137620ced6b2b52a36a6c95ec65dddb98f',
       i686: '8d0cebf1ba4848e065265ba7fb4c858b94e92dc306ee5b68624db4b24aab1021',
     x86_64: '3f1b4296f12579b941ce8a32a037a25fe2f28e60dbf7e4d6ce981170cb5c27f8'
  })

  depends_on 'boost' => :build
  depends_on 'cppunit' => :build
  depends_on 'doxygen' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlibpkg' # R

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-werror"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR}/ install"
  end
end
