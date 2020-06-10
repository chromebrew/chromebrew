require 'package'

class Rlwrap < Package
  description 'A readline wrapper'
  homepage 'https://github.com/hanslub42/rlwrap'
  version '0.43'
  compatibility 'all'
  source_url 'https://github.com/hanslub42/rlwrap/archive/v0.43.tar.gz'
  source_sha256 '29e5a850fbe4753f353b0734e46ec0da043621bdcf7b52a89b77517f3941aade'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rlwrap-0.43-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rlwrap-0.43-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rlwrap-0.43-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rlwrap-0.43-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bc4979020c1fe51241c491c674283c4f0a0b51521baca9b82553d69b6e984855',
     armv7l: 'bc4979020c1fe51241c491c674283c4f0a0b51521baca9b82553d69b6e984855',
       i686: '96078b16189de486043d84e1094b7a63a30d2e890662b414c548a4ee136fb58d',
     x86_64: '288e6db9c583ec36d275a95be28daba69e254ae30d7cd5649214bf1df2b4540e',
  })

  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'readline'

  def self.build
    system "autoreconf --install"
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
