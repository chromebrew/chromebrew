require 'package'

class Finch < Package
  description 'Finch is a chat program which lets you log in to accounts on multiple chat networks simultaneously.'
  homepage 'http://pidgin.im/'
  version '2.12.0'
  source_url 'https://downloads.sourceforge.net/project/pidgin/Pidgin/2.12.0/pidgin-2.12.0.tar.bz2'
  source_sha1 '38f48c48978425b86fc9f4e8ba08216ff379451b'

  depends_on 'glib'
  depends_on 'ncursesw'
  depends_on 'tcl'

  def self.build
    system "sed -i 's,/usr/include,/usr/local/include,g' configure"
    system './configure \
            --disable-avahi \
            --disable-dbus \
            --disable-gtkui \
            --disable-nls \
            --disable-gstreamer \
            --disable-gstreamer-video \
            --disable-gstreamer-interfaces \
            --disable-idn \
            --disable-meanwhile \
            --disable-screensaver \
            --disable-sm \
            --disable-tk \
            --disable-vv \
            --enable-consoleui=yes \
            --includedir=/usr/local/include \
            --oldincludedir=/usr/local/include \
            --without-x'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
