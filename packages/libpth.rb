require 'package'

class Libpth < Package
  description 'Pth is a very portable POSIX/ANSI-C based library for Unix platforms'
  homepage 'https://www.gnu.org/software/pth/'
  version '2.0.7'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/pth/pth-2.0.7.tar.gz'
  source_sha256 '72353660c5a2caafd601b20e12e75d865fd88f6cf1a088b306a3963f0bc77232'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpth-2.0.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpth-2.0.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpth-2.0.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpth-2.0.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6df029d8c9a59cc6bfba3308d362589b5d32e72fecc282dfb6e05e67fac6c387',
     armv7l: '6df029d8c9a59cc6bfba3308d362589b5d32e72fecc282dfb6e05e67fac6c387',
       i686: '49344c2b2eafe8f4490b94bed951b8e7eb31bb45c358d21f531fcd9741e412c6',
     x86_64: 'b82687dc8d4525dd8deee18576ae9ffbb149c2a7a378de68db60fd12de3f6b12',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-optimize'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
