require 'package'

class Readline < Package
  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'https://tiswww.cwru.edu/php/chet/readline/rltop.html'
  version '8.3-rc2'
  license 'GPL-2'
  compatibility 'all'
  # source_url "https://ftpmirror.gnu.org/readline/readline-#{version}.tar.gz"
  # source_sha256 '4df532d8e46e726bb216c63304163a174542cc870109abfe23177fac9e605425'
  source_url 'https://https.git.savannah.gnu.org/git/readline.git'
  git_hashtag '1f2d3a51df1195446e126c5ebca621d9d81809ea'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '85dff3d0aa6a72f845cb8136d631c10b5efbac27ff62e52b1cf3432a5f350669',
     armv7l: '85dff3d0aa6a72f845cb8136d631c10b5efbac27ff62e52b1cf3432a5f350669',
       i686: '1603ee7a4ac94b0d33e5aa75275391d3ec1797c1dc161ae3f332230068913cef',
     x86_64: '3522e3a49daa2a52ff5dfe2d31162579401d888613dbd34147370270d424ed30'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'gcc_lib' # R

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
