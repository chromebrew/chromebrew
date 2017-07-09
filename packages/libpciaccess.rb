require 'package'

class Libpciaccess < Package
  description 'Generic PCI access library'
  homepage 'https://x.org'
  version '0.13'
  source_url 'https://www.x.org/archive/individual/lib/libpciaccess-0.13.tar.gz'
  source_sha256 'afdfe55b23be710751b630073127febef498af35d4a58944fccbef860315f72c'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libpciaccess-0.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libpciaccess-0.13-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libpciaccess-0.13-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libpciaccess-0.13-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1b18e61fa4b0a86f7c812b48858702b7c37714e7d0dcf5b6e9a0276076b63a1e',
     armv7l: '1b18e61fa4b0a86f7c812b48858702b7c37714e7d0dcf5b6e9a0276076b63a1e',
       i686: '38e7ba4c3cd07676111b995d1c599eb0800671f1d38b3edb95bd70cf33da3723',
     x86_64: '45a84189709659783106336d0ebfa3b990bbee843cca69ecb5697a7f530a5fcb',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
