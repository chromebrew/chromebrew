require 'package'

class Perl_xml_parser < Package
  description 'Perl XML::Parser - A perl module for parsing XML documents'
  homepage 'https://metacpan.org/pod/XML::Parser'
  version '2.44'
  source_url 'https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.44.tar.gz'
  source_sha256 '1ae9d07ee9c35326b3d9aad56eae71a6730a73a116b9fe9e8a4758b7cc033216'

  depends_on 'expat'
  depends_on 'perl'

  def self.build
  end

  def self.install
    # install files to build directory
    system 'cpanm', '-l', 'build', '--self-contained', '--force', '.'

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
