require 'package'

class Readline < Package
  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html'
  version '8.2'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/readline/readline-#{version}.tar.gz"
  source_sha256 '3feb7171f16a84ee82ca18a36d7b9be109a52c04f492a053331d7d1095007c35'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2b15b0948ea00612e81fe9118ec797bf7acde887b6d9f6590c8be08cc8e60215',
     armv7l: '2b15b0948ea00612e81fe9118ec797bf7acde887b6d9f6590c8be08cc8e60215',
       i686: '4e0b1ad9c373fb7fe6b8f4bcfd15ee5abef73512d46db51b307966b233ca2794',
     x86_64: '20b80a9206e4327a373c564ac9a041f0192955bd6105a7ddcdecbcc8482081a0'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'gcc_lib' # R

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
