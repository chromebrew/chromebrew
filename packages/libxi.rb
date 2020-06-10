require 'package'

class Libxi < Package
  description 'X.org libXi Client library for XInput'
  homepage 'https://x.org'
  version '1.7.9-0'
  compatibility 'all'
  source_url 'https://github.com/mirror/libXi/archive/libXi-1.7.9.tar.gz'
  source_sha256 'e3bc48654d4c21ac37592e8b41c87a5de73872a243e7b0fb39ebd565be5b943d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxi-1.7.9-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxi-1.7.9-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxi-1.7.9-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxi-1.7.9-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ce61bfb13daa4fb6d8a5ee3afb84c46251e807e78a874a21cb229b4bc3206dcd',
     armv7l: 'ce61bfb13daa4fb6d8a5ee3afb84c46251e807e78a874a21cb229b4bc3206dcd',
       i686: 'da26d60e3bc75d9e6a61f3e15954dd68084f695a0d879fe1ff197d78c409ce6f',
     x86_64: '6bdce3e377a8e7a96b3a606d5c1e64bb251ed5763e2a7b167008c978041e5bc9',
  })

  depends_on 'libx11'

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
