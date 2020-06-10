require 'package'

class Sl < Package
  description 'Steam Locomotive runs across your terminal when you type "sl" as you meant to type "ls".'
  homepage 'https://github.com/mtoyoda/sl'
  version '5.02'
  compatibility 'all'
  source_url 'https://github.com/mtoyoda/sl/archive/5.02.tar.gz'
  source_sha256 '1e5996757f879c81f202a18ad8e982195cf51c41727d3fea4af01fdcbbb5563a'

  def self.build
    system "sed -i 's,curses.h,#{CREW_PREFIX}/include/ncurses/curses.h,' sl.c"
    system "make"
  end

  def self.install
    system "install -Dm755 sl #{CREW_DEST_PREFIX}/bin/sl"
  end
end
