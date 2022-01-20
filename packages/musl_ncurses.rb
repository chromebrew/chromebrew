require 'package'

class Musl_ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more. — Wide character'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.3-20220115'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/mirror/ncurses.git'
  git_hashtag '91e462de27aeecd5b1c8965a6dba078f7a438003'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_ncurses/6.3-20220115_armv7l/musl_ncurses-6.3-20220115-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_ncurses/6.3-20220115_armv7l/musl_ncurses-6.3-20220115-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_ncurses/6.3-20220115_i686/musl_ncurses-6.3-20220115-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_ncurses/6.3-20220115_x86_64/musl_ncurses-6.3-20220115-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8cd01482d8cda2bd798ed3ac249cb2500bc25a17e1c0173400fe4f906582cec3',
     armv7l: '8cd01482d8cda2bd798ed3ac249cb2500bc25a17e1c0173400fe4f906582cec3',
       i686: '8cd18fb303321334f520c282e36aeaa33c31b4cd4d92ed19837ff99c7bedff35',
     x86_64: '793300816d2290bd7519c6edd4d3196470d9dc210c7aec8ba1b4d45a6aa2cf5d'
  })

  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_libunistring' => :build
  depends_on 'musl_libidn2' => :build
  depends_on 'musl_zlib' => :build

  is_static

  def self.build
    load "#{CREW_LIB_PATH}lib/musl.rb"
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
