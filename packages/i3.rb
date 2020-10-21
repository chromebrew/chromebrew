require 'package'

class I3 < Package
  description 'Improved tiling window manager'
  homepage 'https://i3wm.org/'
  version '4.18.2'
  compatibility 'all'
  source_url 'https://i3wm.org/downloads/i3-4.18.2.tar.bz2'
  source_sha256 'b28617d62f308b93817fc9949daffee74cf4a001685de389f3072cb44cf5120c'  

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/i3-4.18.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/i3-4.18.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/i3-4.18.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/i3-4.18.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '07ce3141085991bc04c5af3bba743822e03de73ae3b21783e32cefbeecd689fc',
     armv7l: '07ce3141085991bc04c5af3bba743822e03de73ae3b21783e32cefbeecd689fc',
       i686: '58cf75589a6afcfba39453b3d381ef0674795173c953f9cf9e9bf6d5aa004fbe',
     x86_64: 'c7771c90f1c02daac5b9a2a53fbc9c21cd6088fb3e74048c2308724ef05374e8',
  })
  
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
    end
  end
  
  def self.postinstall
      puts
      puts "To use this package, you need to download XServer XSDL from Google Play Store".lightblue
      puts "Use 'starti3' instead of 'i3' to execute this package".lightblue
      puts "Open XServer XSDL before running 'starti3'"
      system "touch /usr/local/bin/starti3"
      system "echo '#!/bin/sh' >> /usr/local/bin/starti3"
      system "echo 'stopsommelier' >> /usr/local/bin/starti3"
      system "echo 'export DISPLAY=100.115.92.2:0' >> /usr/local/bin/starti3"
      system "echo 'i3 & $1 $2 $3 $4' >> /usr/local/bin/starti3"
      system "chmod +x /usr/local/bin/starti3"
  end
end
