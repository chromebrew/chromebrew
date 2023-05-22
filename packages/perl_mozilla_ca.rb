require 'package'

class Perl_mozilla_ca < Package
  description "Mozilla::CA - Mozilla's CA cert bundle in PEM format"
  homepage 'https://metacpan.org/pod/Mozilla::CA'
  version '20221114-perl5.36'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/H/HA/HAARG/Mozilla-CA-20221114.tar.gz'
  source_sha256 '122c8900000a9d388aa8e44f911cab6c118fe8497417917a84a8ec183971b449'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_mozilla_ca/20211001_armv7l/perl_mozilla_ca-20211001-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_mozilla_ca/20211001_armv7l/perl_mozilla_ca-20211001-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_mozilla_ca/20211001_i686/perl_mozilla_ca-20211001-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_mozilla_ca/20211001_x86_64/perl_mozilla_ca-20211001-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '22f611b19be5a58ea4c13d60120e5da4357f0cc9c476c27e56bb8d150e790753',
     armv7l: '22f611b19be5a58ea4c13d60120e5da4357f0cc9c476c27e56bb8d150e790753',
       i686: 'b7b7376352fc4b2f6e7deebaced880eb5fcf986b1ee7b1678652de7c098edce3',
     x86_64: '5bc064a7d5d2485fdc9837a70733d58e973dcb495b592435e05745f37ac9d441'
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
