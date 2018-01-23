require 'package'

class Tmux < Package
  description 'tmux is a terminal multiplexer'
  homepage 'http://tmux.github.io/'
  version '2.5'
  source_url 'https://github.com/tmux/tmux/releases/download/2.5/tmux-2.5.tar.gz'
  source_sha256 'ae135ec37c1bf6b7750a84e3a35e93d91033a806943e034521c8af51b12d95df'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tmux-2.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tmux-2.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tmux-2.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tmux-2.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f974bcaa1533327eb6beecc4aa2572dd6e557fede27cf91c80832df3b16dc399',
     armv7l: 'f974bcaa1533327eb6beecc4aa2572dd6e557fede27cf91c80832df3b16dc399',
       i686: 'ebdabcaddde645887615ce990d1487c2f7dc50a77785e1dd81595fb930860ac9',
     x86_64: '1901576a8c7ac2ca156e219892c1df41046e76608a64418a0a1dbeb1097dcbd5',
  })

  depends_on 'readline'
  depends_on 'libevent'
  depends_on 'ncurses'

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses ./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
