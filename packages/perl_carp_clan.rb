require 'package'

class Perl_carp_clan < Package
  description 'Carp::Clan - Report errors from perspective of caller of a "clan" of modules'
  homepage 'https://metacpan.org/pod/Carp::Clan'
  version '6.08-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/Carp-Clan-6.08.tar.gz'
  source_sha256 'c75f92e34422cc5a65ab05d155842b701452434e9aefb649d6e2289c47ef6708'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_carp_clan/6.08-perl5.38_armv7l/perl_carp_clan-6.08-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_carp_clan/6.08-perl5.38_armv7l/perl_carp_clan-6.08-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_carp_clan/6.08-perl5.38_i686/perl_carp_clan-6.08-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_carp_clan/6.08-perl5.38_x86_64/perl_carp_clan-6.08-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '202c8b998b4756ff971dcdd1cd9b1222bad278f5cd974e1e2ade979add63beda',
     armv7l: '202c8b998b4756ff971dcdd1cd9b1222bad278f5cd974e1e2ade979add63beda',
       i686: '0f613e91045417a56580ae5c5e94003db554e92ab90c725fcd2dae53ede01fbd',
     x86_64: 'ce783172887ddc4f1f4980885b75278471af598fe6986c98815e95385facfb14'
  })

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
