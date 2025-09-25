require 'package'

class Readline < Package
  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'https://www.gnu.org/software/readline'
  version '8.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/readline.git'
  git_hashtag "readline-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '03591d5160e17e7f9625e3621a61770c969e46d5bacd6451d8849ad029020f02',
     armv7l: '03591d5160e17e7f9625e3621a61770c969e46d5bacd6451d8849ad029020f02',
       i686: '445ce86768f5f9c68b40b4ea63f14e90a0f7c5737b1b0e7a2757e2f4c4534c06',
     x86_64: '8063bcca47645dd5cef9182cc82aafce3871accda72dd19969e67362133293dc'
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
