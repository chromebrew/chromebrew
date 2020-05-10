require 'package'

class Pidgin < Package
  description 'Pidgin is a chat program which lets you log in to accounts on multiple chat networks simultaneously.'
  homepage 'http://pidgin.im/'
  version '2.13.0'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/pidgin/Pidgin/2.13.0/pidgin-2.13.0.tar.bz2'
  source_sha256 '2747150c6f711146bddd333c496870bfd55058bab22ffb7e4eb784018ec46d8f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pidgin-2.13.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pidgin-2.13.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pidgin-2.13.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pidgin-2.13.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c69f235347be1d0200af259304853f61b52d618df109cf155ba1b024c54b8298',
     armv7l: 'c69f235347be1d0200af259304853f61b52d618df109cf155ba1b024c54b8298',
       i686: '599c537f43a41ed36981d07c459a19f29806cfaf13b5cc14f7230f95a77c8876',
     x86_64: '11fcf60b4b62af0bfd76d0f39091b449c6c550ad5185b3f3c4688484be7e4f7f',
  })

  depends_on 'glib'
  depends_on 'gst_plugins_base'
  depends_on 'gtk2'
  depends_on 'libidn2'
  depends_on 'sommelier'

  def self.build
    system "sed -i 's,/usr/include,#{CREW_PREFIX}/include,g' configure"
    system './configure',
      '--disable-avahi',
      '--disable-dbus',
      '--disable-gtkspell',
      '--disable-idn',
      '--disable-meanwhile',
      '--disable-screensaver',
      '--disable-tcl',
      '--disable-tk',
      '--disable-vv',
      '--enable-consoleui=no',
      "--includedir=#{CREW_PREFIX}/include",
      "--oldincludedir=#{CREW_PREFIX}/include",
      "--with-tclconfig=#{CREW_LIB_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--with-x'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
