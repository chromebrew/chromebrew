require 'package'

class Tmux < Package
  description 'tmux is a terminal multiplexer'
  homepage 'http://tmux.github.io/'
  version '2.2'
  source_url 'https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz'
  source_sha256 'bc28541b64f99929fe8e3ae7a02291263f3c97730781201824c0f05d7c8e19e4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tmux-2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tmux-2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tmux-2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tmux-2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd142a07ceb4c7a3a13dd2eba7523f0570f0fed5740d88c23a9eb556b81945bde',
     armv7l: 'd142a07ceb4c7a3a13dd2eba7523f0570f0fed5740d88c23a9eb556b81945bde',
       i686: '4931771ab504e14a25717ead785a1a583883b5d85743f9b5ae6f0ba734028d62',
     x86_64: '3d279327668f3ccb15bddb17c43fbdb9b2ae91dc2b68118bb08c49a60a655675',
  })

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
