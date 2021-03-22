require 'package'

class Sl < Package
  description 'Steam Locomotive runs across your terminal when you type "sl" as you meant to type "ls".'
  homepage 'https://github.com/mtoyoda/sl'
  version '5.02'
  license 'Toyoda'
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

  def self.postinstall
    puts
    puts 'sl does this annoying thing where it doesn\'t allow you to cancel with ^C.'
    puts 'To disable this "feature", run'
    puts 'echo "alias sl=\'sl -e\'" >> ~/.bashrc && source ~/.bashrc'
    puts
  end
end
