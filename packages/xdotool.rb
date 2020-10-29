# Adapted from Arch Linux xdotool PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/xdotool/trunk/PKGBUILD

require 'package'

class Xdotool < Package
  description 'Command-line X11 automation tool'
  version '3.20160805.1-3'
  compatibility 'all'
  source_url 'https://github.com/jordansissel/xdotool/releases/download/v3.20160805.1/xdotool-3.20160805.1.tar.gz'
  source_sha256 '35be5ff6edf0c620a0e16f09ea5e101d5173280161772fca18657d83f20fcca8'

  depends_on 'libxtst'
  depends_on 'libxinerama'
  depends_on 'libxkbcommon'

  def self.build
    system "PREFIX=#{CREW_PREFIX} INSTALLLIB=#{CREW_LIB_PREFIX} make WITHOUT_RPATH_FIX=1"
  end

  def self.install
    system "LDCONFIG=#{CREW_PREFIX}/sbin/ldconfig DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} INSTALLLIB=#{CREW_LIB_PREFIX} make install"
    # Remove execute bit from header file'
    system "chmod -x #{CREW_DEST_DIR}#{CREW_PREFIX}/include/xdo.h"
  end
end
