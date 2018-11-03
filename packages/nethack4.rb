require 'package'

class Nethack4 < Package
  description 'NetHack is a \'roguelike\' game following in the same tradition; the player controls an adventurer delving into a randomly generated dungeon to retrieve the Amulet of Yendor from its depths.'
  homepage 'http://nethack4.org/'
  version '4.3.0-beta2-1'
  source_url 'http://nethack4.org/media/releases/nethack4-4.3-beta2.tar.gz'
  source_sha256 'b143a86b5e1baf55c663ae09c2663b169d265e95ac43154982296a1887d05f15'

  binary_url ({
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nethack4-4.3.0-beta2-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     x86_64: '76fead3fb952f1b03b6bc11350657e91d975325dd48c8f3063dca35d53b836bf',
  })

  depends_on 'buildessential'
  depends_on 'ncurses'
  depends_on 'bison'
  depends_on 'flex'
  depends_on 'perl'

  def self.build
    FileUtils.mkdir("build")
    Dir.chdir("build") do
      system "#{CREW_PREFIX}/bin/perl",
             "../aimake",
             "--config-only",
             "--override-directory", "libdir=#{CREW_LIB_PREFIX}",
             "--override-directory", "specificlibdir=#{CREW_LIB_PREFIX}",
             "--override-directory", "staterootdir=#{CREW_PREFIX}/var",
             "--override-directory", "gamesstatedir=#{CREW_PREFIX}/var/games/nethack4",
             "--directory-layout=prefix",
             "--destdir=#{CREW_DEST_DIR}",
             "-i", "#{CREW_PREFIX}/",
             "--without=gui"
      system "#{CREW_PREFIX}/bin/perl",
             "../aimake"
    end
  end
  def self.install
    Dir.chdir("build") do
      system "#{CREW_PREFIX}/bin/perl",
             "../aimake",
             "--install-only",
             "--override-directory", "libdir=#{CREW_LIB_PREFIX}",
             "--override-directory", "specificlibdir=#{CREW_LIB_PREFIX}",
             "--override-directory", "staterootdir=#{CREW_PREFIX}/var",
             "--override-directory", "gamesstatedir=#{CREW_PREFIX}/var/games/nethack4",
             "--directory-layout=prefix",
             "--destdir=#{CREW_DEST_DIR}",
             "-i", "#{CREW_PREFIX}/",
             "--without=gui"
    end
  end
end
