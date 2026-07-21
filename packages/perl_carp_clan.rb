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
    aarch64: 'c6a1eee444846ab95c6e7074fd46ba776718345c64ac66690ecc90d7e534ed21',
     armv7l: 'c6a1eee444846ab95c6e7074fd46ba776718345c64ac66690ecc90d7e534ed21',
       i686: '356ac57c762939bc73e7e489d17937e299d99c1a4a5568ccbc81ea2ae0024896',
     x86_64: '7661249b5d3d0393421645aa3f28be665ef3041a69065b076a056a470278f516'
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
