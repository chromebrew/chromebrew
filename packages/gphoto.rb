require 'package'

class Gphoto < Package
  description 'The gphoto2 commandline tool for accessing and controlling digital cameras.'
  homepage 'http://www.gphoto.org/'
  version '2.5.23'
  source_url 'https://github.com/gphoto/gphoto2/archive/gphoto2-2_5_23-release.tar.gz'
  source_sha256 'dc78b7f8a88803937301d157b5b32cd45f6defcc771564438a477a7fb05f4489'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gphoto-2.5.23-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gphoto-2.5.23-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gphoto-2.5.23-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gphoto-2.5.23-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '055e881c56a7e40a0208176d08555a8992f15844aedc204f53d99db8e86e1f31',
     armv7l: '055e881c56a7e40a0208176d08555a8992f15844aedc204f53d99db8e86e1f31',
       i686: '72969ad37c17319ce08ca6a80d26d8cfd1bbeac71cbfbcf4ae89f582d6db0f52',
     x86_64: '92fcfd96e8a3a8d40d5a2661d5a9b37dad019ef086b925c97a738c9879c82663',
  })

  depends_on 'libgphoto'
  depends_on 'popt'

  def self.build
    system 'autoreconf -is'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
