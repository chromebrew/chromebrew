require 'package'

class Tmux < Package
  description 'tmux is a terminal multiplexer'
  homepage 'http://tmux.github.io/'
  version '2.2'
  source_url 'https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz'
  source_sha256 'bc28541b64f99929fe8e3ae7a02291263f3c97730781201824c0f05d7c8e19e4'

  depends_on 'readline'
  depends_on 'libevent'
  depends_on 'ncurses'

  def self.build
    system "CPPFLAGS=-I/usr/local/include/ncurses ./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
