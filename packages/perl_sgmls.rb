require 'package'

class Perl_sgmls < Package
  description 'SGMLS - class for postprocessing the output from the sgmls and nsgmls parsers.'
  homepage 'https://search.cpan.org/dist/SGMLSpm/'
  version '1.1-perl-5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/R/RA/RAAB/SGMLSpm-1.1.tar.gz'
  source_sha256 '550c9245291c8df2242f7e88f7921a0f636c7eec92c644418e7d89cfea70b2bd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_sgmls/1.1-perl-5.36_armv7l/perl_sgmls-1.1-perl-5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_sgmls/1.1-perl-5.36_armv7l/perl_sgmls-1.1-perl-5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_sgmls/1.1-perl-5.36_i686/perl_sgmls-1.1-perl-5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_sgmls/1.1-perl-5.36_x86_64/perl_sgmls-1.1-perl-5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c18668defa473525aea779db1eb182554ec26d8d2f4203c4c4cc28cc673e41c8',
     armv7l: 'c18668defa473525aea779db1eb182554ec26d8d2f4203c4c4cc28cc673e41c8',
       i686: '7035942646548233a1e7471f26ded22199fef4623182508d00e93683eb781f5d',
     x86_64: '65c2d87a8ce93e0ffc0e035a7dffa474a28f3fa6ca8fac98bf1384e9252c150a'
  })

  depends_on 'perl_module_build' => :build

  def self.patch
    # For some reason this file doesn't have the proper permissions in the tarball
    FileUtils.chmod 0o644, 'MYMETA.yml'
  end

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
