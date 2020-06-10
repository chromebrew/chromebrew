require 'package'

class Libxscrnsaver < Package
  description 'X.org the X11 Screen Saver extension client library'
  homepage 'http://www.x.org'
  version '1.2.2-0'
  compatibility 'all'
  source_url 'https://www.x.org/archive//individual/lib/libXScrnSaver-1.2.2.tar.gz'
  source_sha256 'e12ba814d44f7b58534c0d8521e2d4574f7bf2787da405de4341c3b9f4cc8d96'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxscrnsaver-1.2.2-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxscrnsaver-1.2.2-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxscrnsaver-1.2.2-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxscrnsaver-1.2.2-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '43bdc049d82141406115751ad9afc49521833fa777a8a693f2f1aaebedc04ccc',
     armv7l: '43bdc049d82141406115751ad9afc49521833fa777a8a693f2f1aaebedc04ccc',
       i686: '1f71684bc973876d66354aae4c9942d706fee619995b47d67bfa38528aca6ca0',
     x86_64: '74dfe48f8e6375d8d45996b645a8cb5b82fb57253580840ef5461f6c60239a7f',
  })

  depends_on 'libx11'
  depends_on 'libxext'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
