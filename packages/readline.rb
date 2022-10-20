require 'package'

class Readline < Package
  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html'
  @_ver = '8.2'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/readline/readline-#{@_ver}.tar.gz"
  source_sha256 '3feb7171f16a84ee82ca18a36d7b9be109a52c04f492a053331d7d1095007c35'

  depends_on 'glibc' # R
  depends_on 'ncurses' # R

  def self.build
    system "./configure \
      #{CREW_OPTIONS} \
      --with-curses \
      --enable-multibyte"
    system 'make', 'SHLIB_LIBS=-Wl,--as-needed -Wl,-ltinfow -Wl,--no-as-needed'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
