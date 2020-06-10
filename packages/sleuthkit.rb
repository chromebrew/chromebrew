require 'package'

class Sleuthkit < Package
  description 'The Sleuth Kit® (TSK) is a library and collection of command line tools that allow you to investigate disk images.'
  homepage 'https://www.sleuthkit.org/sleuthkit/'
  version '4.6.0'
  compatibility 'all'
  source_url 'https://github.com/sleuthkit/sleuthkit/releases/download/sleuthkit-4.6.0/sleuthkit-4.6.0.tar.gz'
  source_sha256 'f52a08ab0de078182c0f2d19d3e1b341424a9e0c1633a61c3b892fb38f9acb97'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sleuthkit-4.6.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sleuthkit-4.6.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sleuthkit-4.6.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sleuthkit-4.6.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5ec2af7f82c975c22a8801bfa28a25ce6544fc079c38987fa9e6276f6198ec3a',
     armv7l: '5ec2af7f82c975c22a8801bfa28a25ce6544fc079c38987fa9e6276f6198ec3a',
       i686: '77311cc6236c21017fe7378309d262ee743edb5065ee00dc4b2e363751097d8d',
     x86_64: 'ec404bf9be6b70fd1638e45a997f26b74ad5522fa878a20a311d962d51562685',
  })

  def self.build
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
