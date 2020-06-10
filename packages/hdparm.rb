require 'package'

class Hdparm < Package
  description 'hdparm is a GNU/Linux shell utility for viewing and manipulating various IDE drive and driver parameters.'
  homepage 'https://directory.fsf.org/wiki/Hdparm'
  version '9.32'
  compatibility 'all'
  source_url 'http://www.ibiblio.org/pub/Linux/system/hardware/hdparm-9.32.tar.gz'
  source_sha256 '90d80632695759ec12c8a9da94471f04bc88d5b73d34fc6a370775b534d09319'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/hdparm-9.32-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/hdparm-9.32-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/hdparm-9.32-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/hdparm-9.32-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f796fcce23fca3c9a2830533b5cb63da0fc2be44c12e8e102db3f06ecf3d3a4e',
     armv7l: 'f796fcce23fca3c9a2830533b5cb63da0fc2be44c12e8e102db3f06ecf3d3a4e',
       i686: '7d0b697a2a64ec02a2b9938f0942b30922afc167daae5a05fea06dc4b480c1b3',
     x86_64: '2c8d90661eaee768b43a87ac0c659fa2f9d24a3b83ef904f0cee61669e867724',
  })

  def self.build
    system "sed -i 's,binprefix = ,binprefix = #{CREW_PREFIX},' Makefile"
    system "sed -i 's,manprefix = /usr,manprefix = #{CREW_PREFIX},' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "-e", "install"
  end
end
