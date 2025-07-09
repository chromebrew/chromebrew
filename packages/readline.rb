require 'package'

class Readline < Package
  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'https://tiswww.cwru.edu/php/chet/readline/rltop.html'
  version '8.3'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/readline/readline-#{version}.tar.gz"
  source_sha256 'fe5383204467828cd495ee8d1d3c037a7eba1389c22bc6a041f627976f9061cc'
  # source_url 'https://https.git.savannah.gnu.org/git/readline.git'
  # git_hashtag "readline-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '85dff3d0aa6a72f845cb8136d631c10b5efbac27ff62e52b1cf3432a5f350669',
     armv7l: '85dff3d0aa6a72f845cb8136d631c10b5efbac27ff62e52b1cf3432a5f350669',
       i686: '445ce86768f5f9c68b40b4ea63f14e90a0f7c5737b1b0e7a2757e2f4c4534c06',
     x86_64: '3522e3a49daa2a52ff5dfe2d31162579401d888613dbd34147370270d424ed30'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R

  def self.build
    system "./configure \
      #{CREW_CONFIGURE_OPTIONS} \
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
