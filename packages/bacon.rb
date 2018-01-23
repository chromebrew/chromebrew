require 'package'

class Bacon < Package
  description 'BaCon is a free BASIC to C translator for Unix-based systems.'
  homepage 'http://www.basic-converter.org/'
  version '3.6'
  source_url 'http://www.basic-converter.org/stable/bacon-3.6.tar.gz'
  source_sha256 'c09d7a69ac1f9dd4c607ca5248e2b20a91c279779bef7a8887e93b77f982f855'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bacon-3.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '468b7c67d22370fcd6fc5ff6b675a07686a74a1c7e5948e7c787f6e22ff78761',
     armv7l: '468b7c67d22370fcd6fc5ff6b675a07686a74a1c7e5948e7c787f6e22ff78761',
       i686: 'ef5f034044d91aeb9954f48a0687840850d661bfe57821504ff41a242ea46ed3',
     x86_64: '504374ac5978d4d203c06bdce9436cd3ef6839d7e4c441ef58b3440b7e7fd982',
  })

  depends_on 'buildessential'

  def self.build
    system 'sed -i "s,/usr/share,\$\(DATADIR\)," Makefile.in'
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--disable-gui'
    system 'make', '-j1' # parallel builds don't work with bacon
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
