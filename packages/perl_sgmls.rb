require 'package'

class Perl_sgmls < Package
  description 'SGMLS - class for postprocessing the output from the sgmls and nsgmls parsers.'
  homepage 'https://search.cpan.org/dist/SGMLSpm/'
  version '1.1-3'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/R/RA/RAAB/SGMLSpm-1.1.tar.gz'
  source_sha256 '550c9245291c8df2242f7e88f7921a0f636c7eec92c644418e7d89cfea70b2bd'

  depends_on 'perl_module_build'

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
