require 'package'

class Tmux < Package
  description 'tmux is a terminal multiplexer'
  homepage 'http://tmux.github.io/'
  version '2.6'
  source_url 'https://github.com/tmux/tmux/releases/download/2.6/tmux-2.6.tar.gz'
  source_sha256 'b17cd170a94d7b58c0698752e1f4f263ab6dc47425230df7e53a6435cc7cd7e8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tmux-2.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tmux-2.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tmux-2.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tmux-2.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '76ca89c630b2be0ed3ed0820d92329b78e0d0ef7ad61a94e3dfbfdcdb9b5cc9f',
     armv7l: '76ca89c630b2be0ed3ed0820d92329b78e0d0ef7ad61a94e3dfbfdcdb9b5cc9f',
       i686: '54e86a02043ca23793838da5d605a3131800c2bfffaec46be3b7a8e0add3f5bb',
     x86_64: '85790c069f950e16d001391a737f67389baa90f3fc44e4eccfd382ed43f8311d',
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
