require 'package'

class Argon2 < Package
  description 'The password hash Argon2, winner of PHC'
  homepage 'https://github.com/P-H-C/phc-winner-argon2'
  version '20190702'
  compatibility 'all'
  source_url 'https://github.com/P-H-C/phc-winner-argon2/archive/20190702.tar.gz'
  source_sha256 'daf972a89577f8772602bf2eb38b6a3dd3d922bf5724d45e7f9589b5e830442c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/argon2-20190702-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/argon2-20190702-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/argon2-20190702-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/argon2-20190702-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '62fb0dbf5a2840752a4715da92c0ac97bac285e9d36f37c1a9ee37e92bb78756',
     armv7l: '62fb0dbf5a2840752a4715da92c0ac97bac285e9d36f37c1a9ee37e92bb78756',
       i686: 'f2774c5515e86d5dc959fc4479d33ff4a9d58a5b779a5fbab8c219d5d5fa5fe9',
     x86_64: 'dfe3a1d783c9b219c3905efc52ba26d7b7d6e9efc57b86ba1898792a0c8dffa2',
  })

  def self.build
    system 'make'
  end

  def self.install
    system 'make',
           "PREFIX=#{CREW_PREFIX}",
           "LIBDIR=#{CREW_LIB_PREFIX}",
           "DESTDIR=#{CREW_DEST_DIR}",
           'install'
    system "install -Dm644 man/argon2.1 #{CREW_DEST_PREFIX}/share/man/man1/argon2.1"
  end
end
