require 'package'

class Perl_carp_clan < Package
  description 'Carp::Clan - Report errors from perspective of caller of a "clan" of modules'
  homepage 'https://metacpan.org/pod/Carp::Clan'
  version "6.08-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/Carp-Clan-6.08.tar.gz'
  source_sha256 'c75f92e34422cc5a65ab05d155842b701452434e9aefb649d6e2289c47ef6708'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '46df58e4c289c5cc5c65623c689fc8ac3165ea890d48b2a8f5b0814c3c4bf6e8',
     armv7l: '46df58e4c289c5cc5c65623c689fc8ac3165ea890d48b2a8f5b0814c3c4bf6e8',
       i686: '823275337142a36a0a27924e1e662d1201d1aafd08c7f55b89908b8c09793b35',
     x86_64: '0b69d985bed227e9dad224fcaf72819a14bedee0e59727e6dbbc582006ee4d03'
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
