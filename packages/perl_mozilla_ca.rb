require 'package'

class Perl_mozilla_ca < Package
  description "Mozilla::CA - Mozilla's CA cert bundle in PEM format"
  homepage 'https://metacpan.org/pod/Mozilla::CA'
  version '20221114-perl5.36'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/H/HA/HAARG/Mozilla-CA-20221114.tar.gz'
  source_sha256 '701bea67be670add5a102f9f8c879402b4983096b1cb0e20dd47d52d7a10666b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_mozilla_ca/20221114-perl5.36_armv7l/perl_mozilla_ca-20221114-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_mozilla_ca/20221114-perl5.36_armv7l/perl_mozilla_ca-20221114-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_mozilla_ca/20221114-perl5.36_i686/perl_mozilla_ca-20221114-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_mozilla_ca/20221114-perl5.36_x86_64/perl_mozilla_ca-20221114-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6fd6c4686ce80c91057ab0badc0cb9d8e1b3e6e0d958cb7fe8ca602c8c456247',
     armv7l: '6fd6c4686ce80c91057ab0badc0cb9d8e1b3e6e0d958cb7fe8ca602c8c456247',
       i686: 'e4d9f6076391eac1ecbc3d4b83269f824218015c78ff7d60c0bb5f84a79262ae',
     x86_64: '51483ba6e6c58b489834d1af3ce529abb6dd4b8612da9ae51c88a1706fd3a970'
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
