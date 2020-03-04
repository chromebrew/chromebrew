require 'package'

class Janet < Package
  description 'Janet is a functional and imperative programming language and bytecode interpreter.'
  homepage 'https://janet-lang.org'
  version '1.7.0'
  source_url 'https://github.com/janet-lang/janet/archive/v1.7.0.tar.gz'
  source_sha256 '2a119f3a79b209a858864e73ca3efda57ac044df3c89762a31480bbea386d2a3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/janet-1.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/janet-1.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/janet-1.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/janet-1.7.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6fbc239bc6374e516ca5e63e988e50a62f5396b83cc1b5ffcc37c484f436ea07',
     armv7l: '6fbc239bc6374e516ca5e63e988e50a62f5396b83cc1b5ffcc37c484f436ea07',
       i686: '5037e0285af569a4a660094599bb251695387fe84936bc53315a107d2d258b61',
     x86_64: 'db58991ce4aef8d19e17abf5e944f39bb94bbb5e7b750c217de36fae71fce1b3',
  })

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
