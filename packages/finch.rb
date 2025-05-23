require 'buildsystems/autotools'

class Finch < Autotools
  description 'Finch is a chat program which lets you log in to accounts on multiple chat networks simultaneously.'
  homepage 'https://pidgin.im/'
  version '2.14.13'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/pidgin/Pidgin/#{version}/pidgin-#{version}.tar.bz2"
  source_sha256 '120049dc8e17e09a2a7d256aff2191ff8491abb840c8c7eb319a161e2df16ba8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f6b578068862f3bc111bf2cc758d35fd45e27493f51204a3daa53c1dcff8e93d',
     armv7l: 'f6b578068862f3bc111bf2cc758d35fd45e27493f51204a3daa53c1dcff8e93d',
       i686: '04c522351f0b79e0ecc19e8bbde06b6517579ac906015cf44a6d97ca6b973be1',
     x86_64: 'c2d5410cb2c083e636e7af8c8f42288dd36ccc4aea23a24250b56854f04e5278'
  })

  depends_on 'e2fsprogs' # R
  depends_on 'glib'
  depends_on 'gnutls'
  depends_on 'krb5' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libgnt'
  depends_on 'libtirpc' # R
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
