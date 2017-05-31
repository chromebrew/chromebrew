require 'package'
 
class Tmux < Package
  description 'tmux is a terminal multiplexer'
  homepage 'http://tmux.github.io/'
  version '2.2'
  source_url 'https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz'
  source_sha1 '5ed1430bc7ef44c227e64e9401c686573dd0791a'
  
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
