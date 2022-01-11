require 'package'

class Libssh2 < Package
  description 'libssh2 is a client-side C library implementing the SSH2 protocol.'
  homepage 'https://www.libssh2.org/'
  @_ver = '1.10.0'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url "https://www.libssh2.org/download/libssh2-1.10.0.tar.gz"
  source_sha256 '2d64e90f3ded394b91d3a2e774ca203a4179f69aebee03003e5a6fa621e41d51'

  def self.patch
    system 'sed', '-i', '/TESTS =/s, mansyntax.sh,,g', 'tests/Makefile.in'
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
              --with-libz"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
