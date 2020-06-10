require 'package'

class Popt < Package
  description 'Library for parsing command line options'
  homepage 'https://directory.fsf.org/wiki/Popt'
  version '1.16'
  compatibility 'all'
  source_url 'http://rpm5.org/files/popt/popt-1.16.tar.gz'
  source_sha256 'e728ed296fe9f069a0e005003c3d6b2dde3d9cad453422a10d6558616d304cc8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/popt-1.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/popt-1.16-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/popt-1.16-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/popt-1.16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6ac9639a832436479b7eb2333178d0334108313a89d15506815580a5284e85fa',
     armv7l: '6ac9639a832436479b7eb2333178d0334108313a89d15506815580a5284e85fa',
       i686: 'ada50c7bc3d4d71d234cea3891112d8c9822bc49c75beb917478e181051a3e78',
     x86_64: '6bdbab0585a94534dd44f9ecd196902166c49aabcf239e4bfb667c08a27dc300',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "gzip -9 #{CREW_DEST_PREFIX}/share/man/man3/popt.3"
  end
end
