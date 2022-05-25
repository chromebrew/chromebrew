require 'package'

class Musl_ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more. — Wide character'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.3-20220402'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/mirror/ncurses.git'
  git_hashtag '64eb5fae1961774e65e46953fa536d12c12f6d76'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_ncurses/6.3-20220402_armv7l/musl_ncurses-6.3-20220402-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_ncurses/6.3-20220402_armv7l/musl_ncurses-6.3-20220402-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_ncurses/6.3-20220402_i686/musl_ncurses-6.3-20220402-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_ncurses/6.3-20220402_x86_64/musl_ncurses-6.3-20220402-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '25144e3cc706bdf9be536b599a636aa93816937335376cdf76f6a3bdd6d34585',
     armv7l: '25144e3cc706bdf9be536b599a636aa93816937335376cdf76f6a3bdd6d34585',
       i686: '1a10f66028936530ebfcda1a1ef82ac8e23c0d643589b603539719875e56f32a',
     x86_64: 'd001c2863a3851651c30d9b0d5b6d6168f7e806b193b8541041b333d4e57e665'
  })

  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_libunistring' => :build
  depends_on 'musl_libidn2' => :build
  depends_on 'musl_zlib' => :build

  is_musl
  is_static
  patchelf

  def self.build
    system "#{MUSL_ENV_OPTIONS} ./configure --prefix=#{CREW_MUSL_PREFIX} \
        --with-static \
        --with-cxx-static \
        --without-debug \
        --enable-pc-files \
        --with-pkg-config-libdir=#{CREW_MUSL_PREFIX}/lib/pkgconfig \
        --enable-widec \
        --without-tests \
        --with-termlib"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
