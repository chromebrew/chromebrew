require 'package'

class Perl_mozilla_ca < Package
  description "Mozilla::CA - Mozilla's CA cert bundle in PEM format"
  homepage 'https://metacpan.org/pod/Mozilla::CA'
  version "20260813-#{CREW_PERL_VER}"
  license 'GPL2'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/L/LW/LWP/Mozilla-CA-#{version.split('-')[0]}.tar.gz"
  source_sha256 '81f0bd9665eacbb6feef13b0fa16fbb30162c09292542b1206434e569196dd9b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3f7c0813e82368f0575084c79bd255925ca20447bf286f02ef9903822663462',
     armv7l: 'a3f7c0813e82368f0575084c79bd255925ca20447bf286f02ef9903822663462',
       i686: 'cf8b2da40570e9aca0b8fb5b6a7c9deb55866b655a5712ab1d13bdd05290ec0a',
     x86_64: 'f3a30770d71c466cc0a1c07aecbf1262c072cd4312fb5c44e257f478e42cfac4'
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
