require 'package'

class Readline < Package
  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html'
  version '8.0'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/readline/readline-8.0.tar.gz'
  source_sha256 'e339f51971478d369f8a053a330a190781acb9864cf4c541060f12078948e461'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/readline-8.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/readline-8.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/readline-8.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/readline-8.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd11d2b5e5180d2752b8e56696865daa60761cb5b93e27706205399baa13bbbb3',
     armv7l: 'd11d2b5e5180d2752b8e56696865daa60761cb5b93e27706205399baa13bbbb3',
       i686: '1dc734cf28063f2b552733cdb04219f7de76f3b59feab84ffe987a421e01a24c',
     x86_64: '19575599c41f80d4fd0753a25f0591952c4eb4c552768432064605d195120626',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-static',
           '--with-curses'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
