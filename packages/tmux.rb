require 'package'

class Tmux < Package
  description 'tmux is a terminal multiplexer'
  homepage 'http://tmux.github.io/'
  version '2.5'
  source_url 'https://github.com/tmux/tmux/releases/download/2.5/tmux-2.5.tar.gz'
  source_sha256 'ae135ec37c1bf6b7750a84e3a35e93d91033a806943e034521c8af51b12d95df'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'readline'
  depends_on 'libevent'
  depends_on 'ncurses'

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses ./configure"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
