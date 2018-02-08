
require 'package'

class Xkeyboard_config < Package
  description 'The non-arch keyboard configuration database for X Window.'
  homepage 'http://www.freedesktop.org/wiki/Software/XKeyboardConfig'
  version '2.21'
  source_url 'https://www.x.org/releases/individual/data/xkeyboard-config/xkeyboard-config-2.21.tar.bz2'
  source_sha256 '30c17049fae129fc14875656da9aa3099e3031d6ce0ee1d77aae190fd9edcec5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xkeyboard_config-2.21-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xkeyboard_config-2.21-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xkeyboard_config-2.21-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xkeyboard_config-2.21-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f60a526d9c26835976d5186115b2bd340772d3e9efd7beae47424703c48da974',
     armv7l: 'f60a526d9c26835976d5186115b2bd340772d3e9efd7beae47424703c48da974',
       i686: '75204643000e91af66ab288e1e7740193d7c1d7ced2a9d8a9f3164a428664242',
     x86_64: '8bdf41c09086fb7209ebb87072b5ef8268176f5051e99f60aa0375046585f776',
  })

  depends_on "util_macros" => :build
  depends_on "intltool" => :build
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
