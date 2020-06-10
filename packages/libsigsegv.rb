require 'package'

class Libsigsegv < Package
  description 'GNU libsigsegv is a library for handling page faults in user mode.'
  homepage 'https://www.gnu.org/software/libsigsegv/'
  version '2.12'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libsigsegv/libsigsegv-2.12.tar.gz'
  source_sha256 '3ae1af359eebaa4ffc5896a1aee3568c052c99879316a1ab57f8fe1789c390b6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsigsegv-2.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsigsegv-2.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsigsegv-2.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsigsegv-2.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e95892871d5cfd7164b3056e87461fd852d1a224ca0a23f0dd73a98e71a83217',
     armv7l: 'e95892871d5cfd7164b3056e87461fd852d1a224ca0a23f0dd73a98e71a83217',
       i686: '626159d654d90139bfb1301323aea5c28b6ad37f895824323471eb7911a5ce4f',
     x86_64: '02097e964faa7116a1e4701f322da97375d8df1a0928cadc05e86b838fe9fef3',
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

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
