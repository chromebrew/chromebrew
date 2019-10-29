require 'package'

class Tmux < Package
  description 'tmux is a terminal multiplexer'
  homepage 'https://tmux.github.io/'
  version '2.9'
  source_url 'https://github.com/tmux/tmux/releases/download/2.9/tmux-2.9.tar.gz'
  source_sha256 '34901232f486fd99f3a39e864575e658b5d49f43289ccc6ee57c365f2e2c2980'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libevent'

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses ./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
