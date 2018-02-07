
require 'package'

class Xkeyboard_config < Package
  description 'The non-arch keyboard configuration database for X Window.'
  homepage 'http://www.freedesktop.org/wiki/Software/XKeyboardConfig'
  version '2.21'
  source_url 'https://www.x.org/releases/individual/data/xkeyboard-config/xkeyboard-config-2.21.tar.bz2'
  source_sha256 '30c17049fae129fc14875656da9aa3099e3031d6ce0ee1d77aae190fd9edcec5'

  depends_on "util_macros"
  depends_on "intltool"
  depends_on "libx11"
  depends_on "gettext" => :build

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
