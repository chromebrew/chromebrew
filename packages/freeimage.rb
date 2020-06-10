require 'package'

class Freeimage < Package
  description 'FreeImage is an Open Source library project for developers who would like to support popular graphics image formats like PNG, BMP, JPEG, TIFF and others as needed by today\'s multimedia applications.'
  homepage 'http://freeimage.sourceforge.net/'
  version '3.18.0'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/freeimage/Source%20Distribution/3.18.0/FreeImage3180.zip'
  source_sha256 'f41379682f9ada94ea7b34fe86bf9ee00935a3147be41b6569c9605a53e438fd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freeimage-3.18.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freeimage-3.18.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freeimage-3.18.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freeimage-3.18.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '87b9d5423bc6efbcaa15cd5bc8789d7d9d155c146b09297a72c5a5b7e0a27be6',
     armv7l: '87b9d5423bc6efbcaa15cd5bc8789d7d9d155c146b09297a72c5a5b7e0a27be6',
       i686: '06dd2952fbd84f64ed7699de9140c5611f4de59ee9d98c6dc008b55671229254',
     x86_64: 'f5f67c7d57c23cd3220f439d7088a7ddd18776ce7a9f1987d2b9a1d20275d9ea',
  })

  depends_on 'dos2unix' => :build

  def self.patch
    system "sed -i 's,-o root -g root ,,g' Makefile.fip"
    system "sed -i 's,-o root -g root ,,g' Makefile.gnu"
  end

  def self.build
    system 'make'
    system 'make -f Makefile.fip'
  end

  def self.install
    system 'make', "INCDIR=#{CREW_DEST_PREFIX}/include", "INSTALLDIR=#{CREW_DEST_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system 'make', "INCDIR=#{CREW_DEST_PREFIX}/include", "INSTALLDIR=#{CREW_DEST_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", '-f', 'Makefile.fip', 'install'
  end
end
