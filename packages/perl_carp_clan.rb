require 'package'

class Perl_carp_clan < Package
  description 'Report errors from perspective of caller of a "clan" of modules'
  homepage 'https://metacpan.org/pod/Carp::Clan'
  version '6.08'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/Carp-Clan-6.08.tar.gz'
  source_sha256 'c75f92e34422cc5a65ab05d155842b701452434e9aefb649d6e2289c47ef6708'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_carp_clan-6.08-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_carp_clan-6.08-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_carp_clan-6.08-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_carp_clan-6.08-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dc90c4812e8dc89fbdc37173fc5e28bdbbf2d4b7ef4e5a1848cafa3b93c92a0e',
     armv7l: 'dc90c4812e8dc89fbdc37173fc5e28bdbbf2d4b7ef4e5a1848cafa3b93c92a0e',
       i686: '937964b41cd2e593626e588c850f402eeea22c0cd0c26621590026599dca70db',
     x86_64: '64a770bb270702be5eaab0092f20d2fdf3176cd73d73710e112f568f9df449eb',
  })

  depends_on 'perl'

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
