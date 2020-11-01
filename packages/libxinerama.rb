require 'package'

class Libxinerama < Package
  description 'Xorg library, Xinerama is an X11 extension which provides support for extending a desktop across multiple displays.'
  homepage 'https://www.x.org/'
  compatibility 'all'
  version '1.1.4'
  source_url 'https://www.x.org/archive/individual/lib/libXinerama-1.1.4.tar.bz2'
  source_sha256 '0008dbd7ecf717e1e507eed1856ab0d9cf946d03201b85d5dcf61489bb02d720'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxinerama-1.1.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxinerama-1.1.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxinerama-1.1.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxinerama-1.1.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '81226a97841812aa627e05e987a06156d84ba790813c13edefe4bbcb9d615e2a',
     armv7l: '81226a97841812aa627e05e987a06156d84ba790813c13edefe4bbcb9d615e2a',
       i686: 'd57dce7574fe2ec96177a011a863d13626772255c6d6e23fbf03632ec848b697',
     x86_64: 'f8f11b3529ecba47aba8b2055b6bba3fa57f155d5fc4882322cf4595bb5e64cd',
  })

  depends_on 'libx11'
  depends_on 'libxcb'
  depends_on 'libxext'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
