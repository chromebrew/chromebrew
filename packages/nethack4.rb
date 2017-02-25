require 'package'

class Nethack4 < Package
  description 'NetHack is a \'roguelike\' game following in the same tradition; the player controls an adventurer delving into a randomly generated dungeon to retrieve the Amulet of Yendor from its depths.'
  homepage 'http://nethack4.org/'
  # "nethack4" fork of nethack with a few patches and a modern build system
  version '4.3.0-beta2'
  source_url 'http://nethack4.org/media/releases/nethack4-4.3-beta2.tar.gz'
  source_sha256 'b143a86b5e1baf55c663ae09c2663b169d265e95ac43154982296a1887d05f15'

  depends_on 'buildessential'
  depends_on 'ncurses'
  depends_on 'bison' => :build
  depends_on 'flex' => :build
  depends_on 'perl' => :build
  depends_on 'zlibpkg' => :build

  def self.build
    target="build"
    system "mkdir -p " + target
    Dir.chdir target  do
      # Force to set codeset to UTF-8 since gcc supports it
      # LANG environment variable doesn't work correctly on chromebook
      system 'sed', '-i', '../aimake', '-e', '/$codeset *= */s/;/; $codeset = "UTF-8";/'

      # Build with rpath pointing at /usr/local
      system "/usr/local/bin/perl ../aimake --config-only -i /usr/local/ --directory-layout=prefix --without=gui"

      # system "/usr/local/bin/perl ../aimake"

      # Need -fPIC for armv7l
      # Need LC_ALL to not use ascii for encoding
      system "LC_ALL=POSIX /usr/local/bin/perl ../aimake --var CFLAGS='-g -O2 -Wall -fPIC' --var CXXFLAGS='-g -O2 -Wall -fPIC'"
    end
  end

  def self.install
    target="build"
    Dir.chdir target  do
      #install in destdir so package manager can keep track
      system "/usr/local/bin/perl ../aimake --install-only -i #{CREW_DEST_DIR}/usr/local/ --directory-layout=prefix --without=gui"
    end
  end
end
