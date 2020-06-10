require 'package'

class Finch < Package
  description 'Finch is a chat program which lets you log in to accounts on multiple chat networks simultaneously.'
  homepage 'http://pidgin.im/'
  version '2.12.0-1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/pidgin/Pidgin/2.12.0/pidgin-2.12.0.tar.bz2'
  source_sha256 '8c3d3536d6d3c971bd433ff9946678af70a0f6aa4e6969cc2a83bb357015b7f8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/finch-2.12.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/finch-2.12.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/finch-2.12.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/finch-2.12.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'db49b25683a033caaf3b228d9766a5e1718b9caee8a05e1ac87107eb43e96138',
     armv7l: 'db49b25683a033caaf3b228d9766a5e1718b9caee8a05e1ac87107eb43e96138',
       i686: 'b7c8bb60997bba78ab44b99ad8b0f4194e57f9af929d581ca46cf1fe8fc484e0',
     x86_64: '4a16d35a9385c84ea85e1d16e06d9351d00a553848feeaa33118b5f8066dbb83',
  })

  depends_on 'glib'
  depends_on 'ncurses'
  depends_on 'tcl'
  depends_on 'perl'
  depends_on 'gnutls'

  def self.build
    system "sed -i 's,/usr/include,#{CREW_PREFIX}/include,g' configure"
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
      "--includedir=#{CREW_PREFIX}/include",
      "--oldincludedir=#{CREW_PREFIX}/include",
      "--with-tclconfig=#{CREW_LIB_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--without-x'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
