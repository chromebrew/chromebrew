require 'package'

class Perl_net_http < Package
  description 'Low-level HTTP connection (client)'
  homepage 'https://metacpan.org/pod/Net::HTTP'
  version '6.22-perl5.36'
  license 'BSD'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/Net-HTTP-6.22.tar.gz'
  source_sha256 '62faf9a5b84235443fe18f780e69cecf057dea3de271d7d8a0ba72724458a1a2'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_http/6.22-perl5.36_armv7l/perl_net_http-6.22-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_http/6.22-perl5.36_armv7l/perl_net_http-6.22-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_http/6.22-perl5.36_i686/perl_net_http-6.22-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_http/6.22-perl5.36_x86_64/perl_net_http-6.22-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '67e30891b2ad79c6aabd2ad2751761b1764c5f815cfe3c9f01c8df418aed2709',
     armv7l: '67e30891b2ad79c6aabd2ad2751761b1764c5f815cfe3c9f01c8df418aed2709',
       i686: '7224e08eab4fd64caa480e5e206b5490b41c078fefefed49fd6ad288e71f87c5',
     x86_64: '4272bd3e9ebda6f15409b297a15e2718a8349dbfd54db33d39ab04b26ef59516'
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
