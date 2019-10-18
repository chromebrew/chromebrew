require 'package'

class Argon2 < Package
  description 'The password hash Argon2, winner of PHC'
  homepage 'https://github.com/P-H-C/phc-winner-argon2'
  version '20190702'
  source_url 'https://github.com/P-H-C/phc-winner-argon2/archive/20190702.tar.gz'
  source_sha256 'daf972a89577f8772602bf2eb38b6a3dd3d922bf5724d45e7f9589b5e830442c'

  binary_url ({
  })
  binary_sha256 ({
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
