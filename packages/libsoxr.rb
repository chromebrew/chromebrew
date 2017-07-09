require 'package'

class Libsoxr < Package
  description 'High quality, one-dimensional sample-rate conversion library.'
  homepage 'https://sourceforge.net/projects/soxr/'
  version '0.1.2'
  source_url 'https://sourceforge.net/projects/soxr/files/soxr-0.1.2-Source.tar.xz'
  source_sha256 '54e6f434f1c491388cd92f0e3c47f1ade082cc24327bdc43762f7d1eefe0c275'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libsoxr-0.1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libsoxr-0.1.2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libsoxr-0.1.2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libsoxr-0.1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9b979e95816ba9c0fd130226805721f146c500920f5af49ab3cbc92a357510d4',
     armv7l: '9b979e95816ba9c0fd130226805721f146c500920f5af49ab3cbc92a357510d4',
       i686: 'f826d9131cdaa905e20dbfe6e887545ff836f542992e990b94a8eef4299f90ce',
     x86_64: 'db89700429e41819e2e16076fd501d9824df24a4c14982513347aa7144031e42',
  })

  depends_on 'cmake'

  def self.build
    system "cmake ."
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
