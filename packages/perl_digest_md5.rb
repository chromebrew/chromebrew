require 'package'

class Perl_digest_md5 < Package
  description 'Digest::MD5 - Perl interface to the MD5 Algorithm'
  homepage 'https://metacpan.org/pod/Digest::MD5'
  version '2.55'
  source_url 'https://cpan.metacpan.org/authors/id/G/GA/GAAS/Digest-MD5-2.55.tar.gz'
  source_sha256 '03b198a2d14425d951e5e50a885d3818c3162c8fe4c21e18d7798a9a179d0e3c'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "yes | perl Makefile.PL PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR}"
    system 'make'
  end

  def self.install
    system 'make', 'install'
  end
end
