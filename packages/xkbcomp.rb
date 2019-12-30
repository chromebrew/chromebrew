require 'package'

class Xkbcomp < Package
  description 'Compile XKB keyboard'
  homepage 'https://www.x.org'
  version '1.4.2'
  source_url 'https://www.x.org/archive/individual/app/xkbcomp-1.4.2.tar.bz2'
  source_sha256 '6dd8bcb9be7e85bd7294abe261b8c7b0539d2fc93e41b80fb8bd013767ce8424'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xkbcomp-1.4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xkbcomp-1.4.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xkbcomp-1.4.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xkbcomp-1.4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b986448256860bea87fec75ffcb92011b3be9c05f1d64c92a64291b514395900',
     armv7l: 'b986448256860bea87fec75ffcb92011b3be9c05f1d64c92a64291b514395900',
       i686: '878d5307237f7b84f1cd2a50ff8bc154c3e3b0f2300cb666fbe609e81ec30ce3',
     x86_64: '0742f2c242ca42e98a7a938a2bbc891220aea671ea1f60ea8f9390d33abcc479',
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
