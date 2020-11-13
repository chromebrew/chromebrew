# Adapted from Arch Linux xdotool PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/xdotool/trunk/PKGBUILD

require 'package'

class Xdotool < Package
  description 'Command-line X11 automation tool'
  homepage 'https://www.semicomplete.com/projects/xdotool'
  version '3.20160805.1'
  compatibility 'all'
  source_url 'https://github.com/jordansissel/xdotool/releases/download/v3.20160805.1/xdotool-3.20160805.1.tar.gz'
  source_sha256 '35be5ff6edf0c620a0e16f09ea5e101d5173280161772fca18657d83f20fcca8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xdotool-3.20160805.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xdotool-3.20160805.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xdotool-3.20160805.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xdotool-3.20160805.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '37b9d630ca048ed377c184d44cbbc261022fabe6bec143abc0c066563f913bc4',
     armv7l: '37b9d630ca048ed377c184d44cbbc261022fabe6bec143abc0c066563f913bc4',
       i686: '0e10fee31413a879f22f1cf91983db10b3878d456c77168e492dff13d9bc3453',
     x86_64: '4ed5c2e4c5b4dfde83c94c017ef7f37e601dc0252ad67341252b38b1a7b47cc2',
  })

  depends_on 'libxtst'
  depends_on 'libxinerama'
  depends_on 'libxkbcommon'

  def self.build
    system "PREFIX=#{CREW_PREFIX} INSTALLLIB=#{CREW_LIB_PREFIX} make WITHOUT_RPATH_FIX=1"
  end

  def self.install
    system "LDCONFIG=#{CREW_PREFIX}/sbin/ldconfig DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} INSTALLLIB=#{CREW_LIB_PREFIX} make install"
    # Remove execute bit from header file'
    system "chmod -x #{CREW_DEST_PREFIX}/include/xdo.h"
  end
end
