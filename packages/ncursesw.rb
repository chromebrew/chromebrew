require 'package'

class Ncursesw < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more. — Wide character'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/ncurses/ncurses-6.2.tar.gz'
  source_sha256 '30306e0c76e0f9f1f0de987cf1c82a5c21e1ce6568b9227f7da5b71cbea86c9d'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/ncursesw-6.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/ncursesw-6.2-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/ncursesw-6.2-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/ncursesw-6.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ebc04cce1d1a629b1b35a7709c94eb3271caa1993c1c9fc948509f3cdfcc4d27',
     armv7l: 'ebc04cce1d1a629b1b35a7709c94eb3271caa1993c1c9fc948509f3cdfcc4d27',
       i686: '2d1152f4c63fbe820ecf2b2271a6f1accfe8cfcec23af821aa77015d3a23c0b9',
     x86_64: '61fcd76a5ad07077b25858e99ca97cb1266fd578c6be28e94ec659b7c5bb20a2'
  })

  def self.build
    # build libncursesw
    FileUtils.mkdir 'ncursesw_build'
    Dir.chdir 'ncursesw_build' do
      system "env #{CREW_ENV_OPTIONS} \
        ../configure #{CREW_OPTIONS} \
          --program-prefix='' \
          --program-suffix='' \
          --with-shared \
          --with-cxx-shared \
          --without-debug \
          --enable-pc-files \
          --with-pkg-config-libdir=#{CREW_LIB_PREFIX}/pkgconfig \
          --enable-widec \
          --without-tests \
          --with-termlib"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'ncursesw_build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
