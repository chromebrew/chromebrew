require 'package'

class Perl_carp_clan < Package
  description 'Carp::Clan - Report errors from perspective of caller of a "clan" of modules'
  homepage 'https://metacpan.org/pod/Carp::Clan'
  version '6.08-2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/Carp-Clan-6.08.tar.gz'
  source_sha256 'c75f92e34422cc5a65ab05d155842b701452434e9aefb649d6e2289c47ef6708'

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
