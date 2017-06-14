require 'package'

class Moonbuggy < Package
  description 'Moon-buggy is a simple character graphics game where you drive some kind of car across the moon\'s surface.'
  homepage 'http://www.seehuhn.de/pages/moon-buggy'
  version '1.0.51'
  source_url 'http://m.seehuhn.de/programs/moon-buggy-1.0.51.tar.gz'
  source_sha1 '7f1c5df99944acfe98eeb5f8d5ab6f28ef61ee7e'

  depends_on 'ncurses'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
