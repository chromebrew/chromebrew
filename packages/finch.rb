require 'buildsystems/autotools'

class Finch < Autotools
  description 'Finch is a chat program which lets you log in to accounts on multiple chat networks simultaneously.'
  homepage 'https://pidgin.im/'
  version '2.14.14'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/pidgin/Pidgin/#{version}/pidgin-#{version}.tar.bz2"
  source_sha256 '0ffc9994def10260f98a55cd132deefa8dc4a9835451cc0e982747bd458e2356'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '15fbc97ec587900451c3054f4548f0681b158356c9d5f7ee8c90cf36f04b47a7',
     armv7l: '15fbc97ec587900451c3054f4548f0681b158356c9d5f7ee8c90cf36f04b47a7',
       i686: '1b8b1e6005493d6652946b21aaeaa50b94933546b4390217fb2816ffc1d73af3',
     x86_64: '4f31f14968e9a0166c3b8953414bfc518d4aff4948e0dc1c77104206a32496d3'
  })

  depends_on 'e2fsprogs' # R
  depends_on 'glib'
  depends_on 'glibc' # R
  depends_on 'gnutls'
  depends_on 'krb5' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libgnt'
  depends_on 'libtirpc' # R
  depends_on 'libxcrypt' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses'
  depends_on 'perl'
  depends_on 'tcl'

  autotools_configure_options "--disable-avahi \
    --disable-dbus \
    --disable-gstreamer \
    --disable-gtkui \
    --disable-idn \
    --disable-meanwhile \
    --disable-nls \
    --disable-tk \
    --disable-vv \
    --enable-consoleui=yes \
    --with-tclconfig=#{CREW_LIB_PREFIX} \
    --with-ncurses-headers=#{CREW_PREFIX}/include/ncursesw \
    --without-x"
end
