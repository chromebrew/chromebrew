require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'http://www.gnu.org/software/binutils/'
  version '2.31.1'
  source_url 'https://ftpmirror.gnu.org/binutils/binutils-2.31.1.tar.xz'
  source_sha256 '5d20086ecf5752cc7d9134246e9588fa201740d540f7eb84d795b1f7a93bca86'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.31.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.31.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.31.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.31.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd95917350f3aea952cbff6226115599cb1ab78b2d0af98c4d4fc6487b6f4f133',
     armv7l: 'd95917350f3aea952cbff6226115599cb1ab78b2d0af98c4d4fc6487b6f4f133',
       i686: '43a870b20c744dd7948e60c8d04971e2f8cb0600b90adb47a2c392bb24251293',
     x86_64: 'd02caabe18956f1e03a7f59539fa5470622ebe833a635ef69535b2277b802222',
  })

  depends_on 'filecmd'
  depends_on 'texinfo'

  def self.build
    system "mkdir -vp build"
    system "for f in $(find . -name configure); do sed -i 's,/usr/bin/file,#{CREW_PREFIX}/bin/file,g' $f; done"
    Dir.chdir("build") do
      system "../configure",
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             "--enable-shared",
             "--disable-maintainer-mode",
             "--enable-gold",
             "--enable-ld=default",
             "--enable-plugins",
             "--disable-bootstrap",
             "--enable-64-bit-bfd",
             "--disable-werror"
      system 'make'
    end
  end

  def self.install
    Dir.chdir("build") do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
