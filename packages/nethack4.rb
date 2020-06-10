require 'package'

class Nethack4 < Package
  description 'NetHack is a \'roguelike\' game following in the same tradition; the player controls an adventurer delving into a randomly generated dungeon to retrieve the Amulet of Yendor from its depths.'
  homepage 'http://nethack4.org/'
  version '4.3.0-beta2-1'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686', 'x86_64'
    source_url 'http://nethack4.org/media/releases/nethack4-4.3-beta2.tar.gz'
    source_sha256 'b143a86b5e1baf55c663ae09c2663b169d265e95ac43154982296a1887d05f15'
  end

  binary_url ({
      i686: 'https://dl.bintray.com/chromebrew/chromebrew/nethack4-4.3.0-beta2-1-chromeos-i686.tar.xz',
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nethack4-4.3.0-beta2-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
      i686: '6d350da249e839266caf16d1f1c67ea39bdf504eb078cdad727aad08581aecfa',
    x86_64: 'f433701d17fb8ac9c1d6ab57f3038ae27e3fe3999ea00e821f296647f622ec99',
  })

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
