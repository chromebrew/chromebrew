require 'package'

class Perl_net_http < Package
  description 'Low-level HTTP connection (client)'
  homepage 'https://metacpan.org/pod/Net::HTTP'
  version '6.22-perl5.38'
  license 'BSD'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/Net-HTTP-6.22.tar.gz'
  source_sha256 '62faf9a5b84235443fe18f780e69cecf057dea3de271d7d8a0ba72724458a1a2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b04bf24c2576c440267f8d7566f91130d055f1ba42cc1accbda16ddde728e8df',
     armv7l: 'b04bf24c2576c440267f8d7566f91130d055f1ba42cc1accbda16ddde728e8df',
       i686: '48525bd2737732d6f5c36813a64eb6e56de2008b3a24805c80a935fabb67226e',
     x86_64: '4ad1e1f3a88be932197edcf365fa046118ca5510e23d25a49f83a0131199a592'
  })

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
