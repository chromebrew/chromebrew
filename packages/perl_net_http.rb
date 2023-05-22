require 'package'

class Perl_net_http < Package
  description 'Low-level HTTP connection (client)'
  homepage 'https://metacpan.org/pod/Net::HTTP'
  version '6.22-perl5.36'
  license 'BSD'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/Net-HTTP-6.22.tar.gz'
  source_sha256 '62faf9a5b84235443fe18f780e69cecf057dea3de271d7d8a0ba72724458a1a2'

  no_compile_needed

  def self.prebuild
    system 'perl', 'Makefile.PL'
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
