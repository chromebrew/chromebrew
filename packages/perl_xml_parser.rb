require 'package'

class Perl_xml_parser < Package
  description 'Perl XML::Parser - A perl module for parsing XML documents'
  homepage 'https://metacpan.org/pod/XML::Parser'
  version '2.46-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.46.tar.gz'
  source_sha256 'd331332491c51cccfb4cb94ffc44f9cd73378e618498d4a37df9e043661c515d'

  depends_on 'expat'
  depends_on 'perl'

  def self.build
  end

  def self.install
    # install files to build directory
    system 'cpanm', '-l', 'build', '--self-contained', '--force', '.'

    # install lib
    libdir = CREW_DEST_DIR + `perl -e 'require Config; print $Config::Config{'"'installsitelib'"'};'`
    FileUtils.mkdir_p libdir
    system "(cd build/lib/perl5; tar cf - .) | (cd #{libdir}; tar xfp -)"

    # install man
    FileUtils.mkdir_p CREW_DEST_MAN_PREFIX
    system "(cd build/man; tar cf - .) | (cd #{CREW_DEST_MAN_PREFIX}; tar xfp -)"

    # conflicts with other perl module installs
    system "find #{CREW_DEST_DIR} -type f -name .packlist -o -name perllocal.pod -delete"
  end

  def self.check
  end
end
