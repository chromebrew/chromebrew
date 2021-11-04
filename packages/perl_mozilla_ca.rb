require 'package'

class Perl_mozilla_ca < Package
  description 'Mozilla CA cert bundle in PEM format'
  homepage 'https://metacpan.org/release/Mozilla-CA'
  version '20200520'
  license 'GPL2'
  compatibility 'all'
  source_url "https://search.cpan.org/CPAN/authors/id/A/AB/ABH/Mozilla-CA-#{version}.tar.gz"
  source_sha256 'b3ca0002310bf24a16c0d5920bdea97a2f46e77e7be3e7377e850d033387c726'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_mozilla_ca/20200520_armv7l/perl_mozilla_ca-20200520-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_mozilla_ca/20200520_armv7l/perl_mozilla_ca-20200520-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_mozilla_ca/20200520_i686/perl_mozilla_ca-20200520-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_mozilla_ca/20200520_x86_64/perl_mozilla_ca-20200520-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'dc31de4d9867145e4bbab0e568fe879203bd7c07fbab47691c3ff8e9231fbe6a',
     armv7l: 'dc31de4d9867145e4bbab0e568fe879203bd7c07fbab47691c3ff8e9231fbe6a',
       i686: '3a324c5509d571aadb9e17b4ed2c63ba58034149379cbdbb475ab8a286b25637',
     x86_64: '1a34e9effb91e7814ca05fed4622461ea9af1c6917a6dc82dc0d407deeca2e9a'
  })

  def self.build
    system "yes | perl Makefile.PL PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR}"
    system 'make'
  end

  def self.install
    system 'make', 'install'
  end
end
