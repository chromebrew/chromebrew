require 'package'

class Xkbcomp < Package
  description 'Compile XKB keyboard'
  homepage 'https://www.x.org'
  version '1.4.3'
  source_url 'https://www.x.org/archive/individual/app/xkbcomp-1.4.3.tar.bz2'
  source_sha256 '06242c169fc11caf601cac46d781d467748c6a330e15b36dce46520b8ac8d435'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xkbcomp-1.4.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xkbcomp-1.4.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xkbcomp-1.4.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xkbcomp-1.4.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '711ac4cd7c2b87345fc7ba1e7ba9b961c17985e636de5aa628ae6ed0c40eff80',
     armv7l: '711ac4cd7c2b87345fc7ba1e7ba9b961c17985e636de5aa628ae6ed0c40eff80',
       i686: '8c7651c05a5d690b06ce52e45b9742109ed9481ac482e27accded5c88bf651de',
     x86_64: '17f0570519a3a9e8da6cb8443fe33491b70900fcd2a420b2af0ab37ea029f07e',
  })

  depends_on 'mesa'
  depends_on 'xcb_util'
    
  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
  
  def self.postinstall
    puts
    puts "xkb configuration files are located in #{CREW_PREFIX}/share/X11/xkb".lightblue
    puts
  end
end
