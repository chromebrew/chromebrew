
require 'package'

class Perl_sgmls < Package
  description 'a set of Perl5 routines for processing the output from the onsgmls SGML parsers.'
  homepage 'http://search.cpan.org/dist/SGMLSpm/'
  version '1.1'
  source_url 'http://search.cpan.org/CPAN/authors/id/R/RA/RAAB/SGMLSpm-1.1.tar.gz'   # can not install it if using https://
  source_sha256 '550c9245291c8df2242f7e88f7921a0f636c7eec92c644418e7d89cfea70b2bd'

  depends_on 'perl'
  depends_on 'perl_module_build'

  def self.build
  end

  def self.install
    # install files to build directory
     system 'cpanm', '-l', "build", '.'      # remove '--self-contained' here, since it will build module_build again.

    # install lib
    libdir = `perl -e 'require Config; print $Config::Config{'"'installsitelib'"'};'`
    system "mkdir -p #{CREW_DEST_DIR}#{libdir}"
    system "(cd build/lib/perl5; tar cf - .) | (cd #{CREW_DEST_DIR}#{libdir}; tar xfp -)"

    # install man
    mandir = "#{CREW_PREFIX}/share/man"
    system "mkdir -p #{CREW_DEST_DIR}#{mandir}"
    system "(cd build/man; tar cf - .) | (cd #{CREW_DEST_DIR}#{mandir}; tar xfp -)"
  end

  def self.check
  end
end
