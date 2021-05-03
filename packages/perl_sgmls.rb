
require 'package'

class Perl_sgmls < Package
  description 'a set of Perl5 routines for processing the output from the onsgmls SGML parsers.'
  homepage 'http://search.cpan.org/dist/SGMLSpm/'
  compatibility 'all'
  license 'GPL-1+ or Artistic'
  version '1.1-2'
  source_url 'https://cpan.metacpan.org/authors/id/R/RA/RAAB/SGMLSpm-1.1.tar.gz'
  source_sha256 '550c9245291c8df2242f7e88f7921a0f636c7eec92c644418e7d89cfea70b2bd'


  depends_on 'perl_module_build'

  def self.build
  end

  def self.install
    # install files to build directory
     system 'cpanm', '-l', 'build', '.' # remove '--self-contained' here, since it will build module_build again.

    # install lib
    libdir = CREW_DEST_DIR + `perl -e 'require Config; print $Config::Config{'"'installsitelib'"'};'`
    FileUtils.mkdir_p libdir
    system "(cd build/lib/perl5; tar cf - .) | (cd #{libdir}; tar xfp -)"

    # install man
    FileUtils.mkdir_p CREW_DEST_MAN_PREFIX
    system "(cd build/man; tar cf - .) | (cd #{CREW_DEST_MAN_PREFIX}; tar xfp -)"

    # Avoid conflicts with other perl module installs
    system "find #{CREW_DEST_DIR} -name .packlist -o -name perllocal.pod -delete"
  end

  def self.check
  end
end
