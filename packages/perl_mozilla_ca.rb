require 'package'

class Perl_mozilla_ca < Package
  description "Mozilla::CA - Mozilla's CA cert bundle in PEM format"
  homepage 'https://metacpan.org/pod/Mozilla::CA'
  version "20261105-#{CREW_PERL_VER}"
  license 'GPL2'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/L/LW/LWP/Mozilla-CA-#{version.split('-')[0]}.tar.gz"
  source_sha256 'b29dfd05d0f0038091fab9d7a184e8e476bc24fb5de5963cd23d21d262e0be10'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f9bf68cfed8868dc5844ca51e102e6938d3c66591639ace40f3de852dcfe1182',
     armv7l: 'f9bf68cfed8868dc5844ca51e102e6938d3c66591639ace40f3de852dcfe1182',
       i686: '37c6e5bfa1f75b80ed378a2329ce2d3a634471998310dbeaaf62c6fd849ff1fd',
     x86_64: '9496c526be085c72d779e8bdb53e5f29ac05d32abfdc820f482e7d99430efab0'
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
