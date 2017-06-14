require 'package'

class Libsigsegv < Package
  description 'GNU libsigsegv is a library for handling page faults in user mode.'
  homepage 'https://www.gnu.org/software/libsigsegv/'
  version '2.11'
  source_url 'ftp://ftp.gnu.org/gnu/libsigsegv/libsigsegv-2.11.tar.gz'
  source_sha1 '186dea8ae788395476bd7cbaf38c17ebe82e1777'

  # Not duplicating armv7l as aarch64 for the safe since libsigsegv traces stack.
  # I'm not sure differences between armv7l stack and aarch64 stack.
  binary_url ({
    armv7l:  'https://github.com/jam7/chromebrew/releases/download/binaries/libsigsegv-2.11-chromeos-armv7l.tar.xz',
    x86_64:  'https://github.com/jam7/chromebrew/releases/download/binaries/libsigsegv-2.11-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    armv7l:  '49ac940d93c9c174194a96444ac4006d8ebd6d53',
    x86_64:  '3fdafd698589fffabc215dea2b559dacf94b4500',
  })

  def self.build
    system "./configure", "--enable-shared", "--disable-static", "--with-pic"
    system "make"
  end

  def self.install
    system "make check"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
