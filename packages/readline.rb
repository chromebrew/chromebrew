require 'package'

class Readline < Package
  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'https://tiswww.cwru.edu/php/chet/readline/rltop.html'
  version '8.3-rc1'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/readline/readline-#{version}.tar.gz"
  source_sha256 '4df532d8e46e726bb216c63304163a174542cc870109abfe23177fac9e605425'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f2cfc8d63b451d41775745e249fc9d5c34323f1ec28e44b3e0a03e596b72c307',
     armv7l: 'f2cfc8d63b451d41775745e249fc9d5c34323f1ec28e44b3e0a03e596b72c307',
       i686: '3ebb7933e2d68c84911303de7f035e0ebfa3f2a55193166ea911250b1df4fc2c',
     x86_64: '338cb34141f881537ff58b26d2cb9d25445e08074e0de6fe0d462dc72f127d39'
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
