require 'package'

class Libunistring < Package
  description 'A library that provides functions for manipulating Unicode strings and for manipulating C strings according to the Unicode standard.'
  homepage 'https://www.gnu.org/software/libunistring/'
  version '0.9.10'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libunistring/libunistring-0.9.10.tar.xz'
  source_sha256 'eb8fb2c3e4b6e2d336608377050892b54c3c983b646c561836550863003c05d7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bd3254d74558de91f176d933d0e4c71eb34b82e245abfbbce9fbee675e89e6fc',
     armv7l: 'bd3254d74558de91f176d933d0e4c71eb34b82e245abfbbce9fbee675e89e6fc',
       i686: '88cb3cbfdf6c108045cf63d5aa70b2d036fceacc93f0ead76858381db4268c76',
     x86_64: 'd0fccb9b680e38517ce95483fcbac289ba835aa79e5c106bc21ec8de7872a13b',
  })

  depends_on 'glibc'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-static',
           '--enable-shared'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
