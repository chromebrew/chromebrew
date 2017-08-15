require 'package'

class Libx11 < Package
  description 'C interface to the X window system'
  homepage 'https://x.org'
  version '1.6.5'
  source_url 'https://www.x.org/archive/individual/lib/libX11-1.6.5.tar.gz'
  source_sha256 '3abce972ba62620611fab5b404dafb852da3da54e7c287831c30863011d28fb3'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libx11-1.6.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libx11-1.6.5-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libx11-1.6.5-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libx11-1.6.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3f588e3893585ce07fecbb85e15bd0c4a7a94dd26c53878219d70c9f2252c16d',
     armv7l: '3f588e3893585ce07fecbb85e15bd0c4a7a94dd26c53878219d70c9f2252c16d',
       i686: '94ce79efe402015d08bfa95c5138324c8449828294f128f4129f4126401c3f18',
     x86_64: '3122ccd64702d2d477dbb28f2351cb346cecdf19e9a562534974ca38eefaa19c',
  })

  depends_on 'kbproto'
  depends_on 'libxcb'
  depends_on 'xproto'
  depends_on 'inputproto'
  depends_on 'xextproto'
  depends_on 'libxtrans'
  
  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
