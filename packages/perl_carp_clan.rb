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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_carp_clan/6.08-2_armv7l/perl_carp_clan-6.08-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_carp_clan/6.08-2_armv7l/perl_carp_clan-6.08-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_carp_clan/6.08-2_i686/perl_carp_clan-6.08-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_carp_clan/6.08-2_x86_64/perl_carp_clan-6.08-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '42846add31b8c3a6f2253cc8464acc389065a5116ac4ba8bde5436c6396103bc',
     armv7l: '42846add31b8c3a6f2253cc8464acc389065a5116ac4ba8bde5436c6396103bc',
       i686: 'bfe068d90471ef074e81ec0ad3f2be44dce6a1abb74ab99c770e24308a8c9359',
     x86_64: 'f00f6525e8eaaf590f37318f100f5a8906e3bd369f23c030f993acd58fa6b96b'
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
