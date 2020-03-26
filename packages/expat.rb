require 'package'

class Expat < Package
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://sourceforge.net/projects/expat/'
  version '2.2.9'
  source_url 'https://prdownloads.sourceforge.net/project/expat/expat/2.2.9/expat-2.2.9.tar.bz2'
  source_sha256 'f1063084dc4302a427dabcca499c8312b3a32a29b7d2506653ecc8f950a9a237'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/expat-2.2.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/expat-2.2.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/expat-2.2.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/expat-2.2.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2bac1ab7a27c48690d47e28b5826818095932bb9210ec46b69e173a088ead177',
     armv7l: '2bac1ab7a27c48690d47e28b5826818095932bb9210ec46b69e173a088ead177',
       i686: '331b397c748e8bfeef19ac927236b19ea03d841e7e15788850f8a207c3ab473b',
     x86_64: '1f339732173e08417ae6c9f12ff898020a517c345afd34682971ffa7d982a306',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-shared',
           '--disable-static',
           '--with-pic'
    system 'make'
  end

  def self.check
    system "make", "check"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
