
require 'package'

class Xkeyboard_config < Package
  description 'The non-arch keyboard configuration database for X Window.'
  homepage 'http://www.freedesktop.org/wiki/Software/XKeyboardConfig'
  version '2.29'
  source_url 'https://www.x.org/releases/individual/data/xkeyboard-config/xkeyboard-config-2.29.tar.bz2'
  source_sha256 '1d4175278bf06000683656763a8b1d3282c61a314b6db41260c8efe92d621802'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on "util_macros" => :build
  depends_on "intltool" => :build
  depends_on "libx11"
  depends_on "gettext" => :build

  def self.build
    system "sed -i 's,/usr/bin/python3,#{CREW_PREFIX}/bin/python3,' ./rules/compat/map-variants.py"i
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
