require 'package'

class Di < Package
  description '\'di\' is a disk information utility, displaying everything (and more) that your \'df\' command does.'
  homepage 'http://gentoo.com/di/'
  version '4.46'
  source_url 'https://gentoo.com/di/di-4.46.tar.gz'
  source_sha256 '3cc77280618d5e7b61eeedd3f25bb8521a6de5420793d73e217ce2c83d8e5333'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/di-4.46-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/di-4.46-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/di-4.46-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/di-4.46-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd21f892ca57b54da560cdaa3509e25ca658ec4643281cdbde5a25a1375c4ffbb',
     armv7l: 'd21f892ca57b54da560cdaa3509e25ca658ec4643281cdbde5a25a1375c4ffbb',
       i686: 'f35449a564d83e81c51823609efb3ba8f9a132f3f300e3581ac0191d1eef2c16',
     x86_64: '4125910072a4aa818af4016bcf95589e0943d5186093ea87352ffe3db895e483',
  })

  def self.build
    system "sed -i 's,prefix = #{CREW_PREFIX},prefix = #{CREW_DEST_PREFIX},' Makefile"
    system "sed -i 's,USER = root,USER = #{USER},' Makefile" # set correct owner
    system "sed -i 's,GROUP = bin,GROUP = #{USER},' Makefile" # set correct group
    system 'make -e dioptions.dat'
    system 'make -e'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "-e", "install"
  end
end
