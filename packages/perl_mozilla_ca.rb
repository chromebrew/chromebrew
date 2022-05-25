require 'package'

class Perl_mozilla_ca < Package
  description "Mozilla::CA - Mozilla's CA cert bundle in PEM format"
  homepage 'https://metacpan.org/pod/Mozilla::CA'
  version '20221114-perl5.38'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/H/HA/HAARG/Mozilla-CA-20221114.tar.gz'
  source_sha256 '701bea67be670add5a102f9f8c879402b4983096b1cb0e20dd47d52d7a10666b'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_mozilla_ca/20221114-perl5.38_armv7l/perl_mozilla_ca-20221114-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_mozilla_ca/20221114-perl5.38_armv7l/perl_mozilla_ca-20221114-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_mozilla_ca/20221114-perl5.38_i686/perl_mozilla_ca-20221114-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_mozilla_ca/20221114-perl5.38_x86_64/perl_mozilla_ca-20221114-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f95da4ac61edaa88016e3ce836a7fbe6bc3fac5fd266e4067840d3ae6a4fc8d7',
     armv7l: 'f95da4ac61edaa88016e3ce836a7fbe6bc3fac5fd266e4067840d3ae6a4fc8d7',
       i686: 'd86d9a4da3ef6f8b7174f40fb6bbf26b47bf56d89b2df095f99aa1040860dbb8',
     x86_64: 'bea0fd141dd254022d96d8d9d3879ca3b0ab13caba91cadceed01080b8aac3ac'
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
