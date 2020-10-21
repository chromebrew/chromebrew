require 'package'

class I3 < Package
  description 'Improved tiling window manager'
  homepage 'https://i3wm.org/'
  version '4.18.3'
  compatibility 'all'
  source_url 'https://i3wm.org/downloads/i3-4.18.3.tar.bz2'
  source_sha256 '53ae7903fad6eea830d58e949698e4a502c432c0d0a582659a0a59b1b995b10d'  
  
  depends_on 'libev'
  depends_on 'startup_notification'
  depends_on 'xcb_util_cursor'
  depends_on 'xcb_util_keysyms'
  depends_on 'xcb_util_wm'
  depends_on 'xcb_util_xrm'
  depends_on 'yajl'
  depends_on 'wayland' => :build
  depends_on 'sommelier'
  
  def self.build
    system "./configure #{CREW_OPTIONS} --disable-builddir --disable-maintainer-mode --enable-mans"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      system "for f in \$(ls #{CREW_BUILD}-*); do g=\$(echo \$f | sed 's,#{CREW_BUILD}-,,'); ln -sf \$f \$g; done"
     system "echo '#!/bin/sh' > starti3"
     system "echo 'stopsommelier' >> starti3"
     system "echo 'export DISPLAY=100.115.92.2:0' >> starti3"
     system "echo 'i3 \"$@\"' >> starti3"
     system "echo 'export DISPLAY=:0' >> starti3"
     system "echo 'initsommelier' >> starti3"
     system "chmod +x starti3"
    end
  end
  
  def self.postinstall
      puts
      puts "To use this package, you need to download XServer XSDL from Google Play Store".lightblue
      puts "Use 'starti3' instead of 'i3' to execute this package".lightblue
      puts "Open XServer XSDL before running 'starti3'"
  end
end
