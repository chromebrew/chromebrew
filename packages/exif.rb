require 'package'

class Exif < Package
  description 'A small command-line utility to show EXIF information hidden in JPEG files'
  homepage 'https://libexif.github.io/'
  version '0.6.21'
  compatibility 'all'
  source_url 'https://github.com/libexif/exif/archive/exif-0_6_21-release.tar.gz'
  source_sha256 'f55e125eee6c2a75d367d3b388bcd7bea75dc944fabe8671bb32e889192f4b77'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/exif-0.6.21-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/exif-0.6.21-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/exif-0.6.21-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/exif-0.6.21-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8f8de193c0571c268e8004876a0365178237107d2e21d44766ef128f204adcb3',
     armv7l: '8f8de193c0571c268e8004876a0365178237107d2e21d44766ef128f204adcb3',
       i686: '66264ec4145cb0ea008eeb7a584dbda2339e1b3f2209e712e5bb8b6e794f3db8',
     x86_64: '5d99ef721aafe110f565698a8ee42d258d89748cbb37073175781af7ec7cc617',
  })

  depends_on 'libexif'
  depends_on 'popt'

  def self.build
    system 'autoreconf -i -f'
    system "sed -i '69,70d' po/Makefile.in.in"
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
