require 'package'

class Libxkbcommon < Package
  description 'Keymap handling library for toolkits and window systems'
  homepage 'http:s//xkbcommon.org'
  version '0.8.0'
  source_url 'https://xkbcommon.org/download/libxkbcommon-0.8.0.tar.xz'
  source_sha256 'e829265db04e0aebfb0591b6dc3377b64599558167846c3f5ee5c5e53641fe6d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbcommon-0.8.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbcommon-0.8.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbcommon-0.8.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbcommon-0.8.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f3a2e09f2d405de3c8709388c2723413e5cd23d4b744a429303408ca8608801f',
     armv7l: 'f3a2e09f2d405de3c8709388c2723413e5cd23d4b744a429303408ca8608801f',
       i686: '7de65d43457f7d75c1ba374cb0c21a5f83b7ea5e2be8d1c1cdb7baff856a1b1e',
     x86_64: '4e95bd2ac160dfe3e458f166c0b434931666c38c8fa5e7d9a0391ad936ddfb1a',
  })

  depends_on 'bison'
  depends_on 'libwayland'
  depends_on 'xkeyboard_config'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
