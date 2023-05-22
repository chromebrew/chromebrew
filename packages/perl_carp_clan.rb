require 'package'

class Perl_carp_clan < Package
  description 'Carp::Clan - Report errors from perspective of caller of a "clan" of modules'
  homepage 'https://metacpan.org/pod/Carp::Clan'
  version '6.08-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/Carp-Clan-6.08.tar.gz'
  source_sha256 'c75f92e34422cc5a65ab05d155842b701452434e9aefb649d6e2289c47ef6708'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_carp_clan/6.08-perl5.36_armv7l/perl_carp_clan-6.08-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_carp_clan/6.08-perl5.36_armv7l/perl_carp_clan-6.08-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_carp_clan/6.08-perl5.36_i686/perl_carp_clan-6.08-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_carp_clan/6.08-perl5.36_x86_64/perl_carp_clan-6.08-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0a1416461c66b913300eaffde6e47c4adacb1c151e41abfaaba4c444ca8cf27b',
     armv7l: '0a1416461c66b913300eaffde6e47c4adacb1c151e41abfaaba4c444ca8cf27b',
       i686: '2b79dd4db27855fd20398840631b5ca55e65b6461c4827fba77383962a8d0ba6',
     x86_64: '89cc85d2c0d9a5af8a7cdc3278fdaf2e82e45e081ea73dbcfae1641a5b004e8d'
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
