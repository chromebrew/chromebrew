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
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_sgmls/1.1-perl-5.36_i686/perl_sgmls-1.1-perl-5.36-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_sgmls/1.1-perl-5.36_x86_64/perl_sgmls-1.1-perl-5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: '0e3384c54492b0cc504637e60f6aab43f0831fe02e811880b2e3e5613026031d',
  x86_64: 'f74c528789d0d368af0aa4ee8b025ae7242f7bcf6ab476aa44d371eadac9c439'
  })

  depends_on 'perl_module_build' => :build

  def self.patch
    # For some reason this file doesn't have the proper permissions in the tarball
    system 'chmod 0644 MYMETA.yml'
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
