require 'package'

class Libsigsegv < Package
  description 'GNU libsigsegv is a library for handling page faults in user mode.'
  homepage 'https://www.gnu.org/software/libsigsegv/'
  version '2.11'
  source_url 'ftp://ftp.gnu.org/gnu/libsigsegv/libsigsegv-2.11.tar.gz'
  source_sha256 'dd7c2eb2ef6c47189406d562c1dc0f96f2fc808036834d596075d58377e37a18'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libsigsegv-2.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libsigsegv-2.11-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libsigsegv-2.11-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libsigsegv-2.11-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '848d1532b32bd8833013093ae05f42bc7289d12aafcd1b29152598deefcd546c',
     armv7l: '848d1532b32bd8833013093ae05f42bc7289d12aafcd1b29152598deefcd546c',
       i686: '4f2ed1ee3c5827881d8fbf0e0fe59fa8a9d4f581e5adc03a93ff97e8032a25f4',
     x86_64: 'a6e4750facffe105650502313c2622368e0923919adeb38865e8875b88288565',
  })

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--enable-shared", "--disable-static", "--with-pic"
    system "make"
  end

  def self.install
    system "make check"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
