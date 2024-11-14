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
    aarch64: '0ec48077b0e840bd18e60edbeb3819c82985b625cc28f8bda6835b6bcb49df60',
     armv7l: '0ec48077b0e840bd18e60edbeb3819c82985b625cc28f8bda6835b6bcb49df60',
       i686: '253526cb198bbaab51f904bd2c8945d87abcb505869a9c0932016506b0f8e210',
     x86_64: 'e578a9f51a939058de80137c237ca21143b9b4652a8f58c6070c720f23946430'
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
