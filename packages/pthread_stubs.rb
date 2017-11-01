require 'package'

class Pthread_stubs < Package
  description 'pthread stubs to get libX11 working'
  homepage 'https://x.org'
  version '0.1'
  source_url 'https://www.x.org/archive/individual/lib/libpthread-stubs-0.1.tar.gz'
  source_sha256 'f8f7ca635fa54bcaef372fd5fd9028f394992a743d73453088fcadc1dbf3a704'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pthread_stubs-0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pthread_stubs-0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pthread_stubs-0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pthread_stubs-0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bb90a4b181cae20cdfeeb636092f4f4b1e4a63a8c1601310efc5058a4404302a',
     armv7l: 'bb90a4b181cae20cdfeeb636092f4f4b1e4a63a8c1601310efc5058a4404302a',
       i686: '821f2fbd827feb53a13d86a5161fca73930b2ae2c3b9c06104c52403e0729642',
     x86_64: '9775808cf6699e3ff2457bb7f715c47d0287ecef15a8e02a1a832b5b0ebf5a21',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
