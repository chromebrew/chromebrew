require 'package'

class Pthread_stubs < Package
  description 'pthread stubs to get libX11 working'
  homepage 'https://x.org'
  version '0.1-0'
  source_url 'https://www.x.org/archive/individual/lib/libpthread-stubs-0.1.tar.gz'
  source_sha256 'f8f7ca635fa54bcaef372fd5fd9028f394992a743d73453088fcadc1dbf3a704'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pthread_stubs-0.1-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pthread_stubs-0.1-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pthread_stubs-0.1-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pthread_stubs-0.1-0-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: 'c8e8d831092056519f8aaa0dee24324b5de575cc611bd3c9d74eac175324bf74',
     armv7l: 'c8e8d831092056519f8aaa0dee24324b5de575cc611bd3c9d74eac175324bf74',
       i686: 'ec5ca1ccec25be5ed81efda787f1138962b7b18eb8bf94592647510f09bc225d',
     x86_64: '65bb08fbc6a2f45d78906fc691b1feb88b1e30d9263ec030d5a2933018e62e3e',

  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
