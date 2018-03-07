require 'package'

class Argon2 < Package
  description 'The password hash Argon2, winner of PHC'
  homepage 'https://github.com/P-H-C/phc-winner-argon2'
  version '20171227'
  source_url 'https://github.com/P-H-C/phc-winner-argon2/archive/20171227.tar.gz'
  source_sha256 'eaea0172c1f4ee4550d1b6c9ce01aab8d1ab66b4207776aa67991eb5872fdcd8'

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
