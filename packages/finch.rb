require 'package'

class Finch < Package
  description 'Finch is a chat program which lets you log in to accounts on multiple chat networks simultaneously.'
  homepage 'http://pidgin.im/'
  version '2.12.0-1'
  source_url 'https://downloads.sourceforge.net/project/pidgin/Pidgin/2.12.0/pidgin-2.12.0.tar.bz2'
  source_sha256 '8c3d3536d6d3c971bd433ff9946678af70a0f6aa4e6969cc2a83bb357015b7f8'

  depends_on 'glib'
  depends_on 'ncursesw'
  depends_on 'tcl'
  depends_on 'perl'
  depends_on 'gnutls'

  def self.build
    system "sed -i 's,/usr/include,/usr/local/include,g' configure"
    system './configure',
      '--disable-avahi',
      '--disable-dbus',
      '--disable-gtkui',
      '--disable-nls',
      '--disable-gstreamer',
      '--disable-gstreamer-video',
      '--disable-gstreamer-interfaces',
      '--disable-idn',
      '--disable-meanwhile',
      '--disable-screensaver',
      '--disable-sm',
      '--disable-tk',
      '--disable-vv',
      '--enable-consoleui=yes',
      '--includedir=/usr/local/include',
      '--oldincludedir=/usr/local/include',
      "--with-tclconfig=#{CREW_LIB_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--without-x'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
