require 'package'

class Nethack < Package
  description 'Nethack is a classic roguelike. Descend through the dungeon and retrieve the Amulet of Yendor.'
  homepage 'https://www.nethack.org/'
  version '3.6.0'
  compatibility 'all'
  source_url 'https://github.com/NetHack/NetHack/archive/NetHack-3.6.0_Release.tar.gz'
  source_sha256 '5735e4d132d8aec0c49f0e2a72156c7cbe84ea7b5a3153531da61aa660c668a1'

  def self.patch
    # Apply a patch to set a hints file that will work for the current build environment.
    system "curl -L 'https://gist.githubusercontent.com/anonymous/77b05c6cd87628ab3cb944e75ecc45b7/raw/d5f327450aa6b4d50cafb5352fad06ed60f91b69/nethack_chromebrew.patch' | patch -p0"
  end

  def self.build
    system '/sys/unix/setup.sh', './sys/unix/hints/linux'
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_DEST_PREFIX}", 'install'
    system 'mkdir', "#{CREW_DEST_PREFIX}/bin/"
    system 'sed', '-i', "s|^HACKDIR=.*$|HACKDIR=#{CREW_PREFIX}/games/lib/nethackdir|g", "#{CREW_DEST_PREFIX}/games/nethack"
    system 'cp', "#{CREW_DEST_PREFIX}/games/nethack", "#{CREW_DEST_PREFIX}/bin/nethack"
  end
end
