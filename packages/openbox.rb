require 'package'

class Openbox < Package                 # The first character of the class name must be upper case
  description 'Openbox is a highly configurable, next generation window manager with extensive standards support.'
  homepage 'http://openbox.org/'
  version '3.6.1'
  compatibility 'all'
  source_url 'http://openbox.org/dist/openbox/openbox-3.6.1.tar.xz'
  source_sha256 'abe75855cc5616554ffd47134ad15291fe37ebbebf1a80b69cbde9d670f0e26d'   # Use the command "sha256sum"

  depends_on 'libev'
  depends_on 'startup_notification'
  depends_on 'xcb_util_cursor'
  depends_on 'xcb_util_keysyms'
  depends_on 'xcb_util_wm'
  depends_on 'xcb_util_xrm'
  depends_on 'yajl'
  depends_on 'wayland' => :build
  depends_on 'xorg_proto'
  depends_on 'glib'
  depends_on 'libxfixes'
  depends_on 'libsm'
  depends_on 'pango' => :build
  depends_on 'libx11' => :build
  depends_on 'sommelier'

  ENV['CFLAGS'] = "-lX11 -lXau"
  def self.build                   # the steps required to build the package
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install                 # the steps required to install the package
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "echo '#!/bin/bash' > startopenbox"
    system "echo 'stopsommelier' >> startopenbox"
    system "echo 'echo am start x.org.server/.MainActivity | sudo android-sh' >> startopenbox"
    system "echo 'echo Starting XServer XSDL' >> startopenbox"
    system "echo 'sleep 10' >> startopenbox"
    system "echo 'export DISPLAY=100.115.92.2:0' >> startopenbox"
    system "echo 'openbox' >> startopenbox"
    system "echo 'echo XServer closed or logged out session' >> startopenbox"
    system "echo 'initsommelier' >> startopenbox"
    system "echo 'export DISPLAY=:0' >> startopenbox"
    system "install -Dm755 startopenbox #{CREW_DEST_PREFIX}/bin/startopenbox"
  end

  def self.check                   # the steps required to check if the package was built ok
    system "make", "check"
  end
  def self.postinstall
      puts
      puts "To use this package, you need to download XServer XSDL from Google Play Store".lightblue
      puts "Use 'startopenbox' instead of 'openbox' to execute this package".lightblue
  end
end
