require 'package'

class Shpkg < Package
  description 'A simple dpkg-compatible package manager implemented in Bash.'
  homepage 'https://github.com/JL2210/shpkg'
  version '0.1.0'
  source_url 'https://github.com/JL2210/shpkg/releases/download/v0.1.0/shpkg-0.1.0.tar.gz'
  source_sha256 'a5a56e24160986d1392cc34efe48b00ace2e8e1df813ea5cddb0e129effc74ba'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'make',
           "PREFIX=#{CREW_PREFIX}",
           "SYSCONFDIR=#{CREW_PREFIX}/etc",
           "LOCALSTATEDIR=#{CREW_PREFIX}/var"
  end

  def self.install
    system "make",
           "PREFIX=#{CREW_PREFIX}",
           "SYSCONFDIR=#{CREW_PREFIX}/etc",
           "LOCALSTATEDIR=#{CREW_PREFIX}/var",
           "DESTDIR=#{CREW_DEST_DIR}",
           "install"
  end
end
