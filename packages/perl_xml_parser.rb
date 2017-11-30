require 'package'

class Perl_xml_parser < Package
  description 'Perl XML::Parser - A perl module for parsing XML documents'
  homepage 'https://metacpan.org/pod/XML::Parser'
  version '2.44'
  source_url 'https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.44.tar.gz'
  source_sha256 '1ae9d07ee9c35326b3d9aad56eae71a6730a73a116b9fe9e8a4758b7cc033216'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_parser-2.44-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_parser-2.44-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_parser-2.44-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_parser-2.44-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '08721209d18f180afd8906e8e1d774a1cd148398fae1b638f58e049d8ff98bf5',
     armv7l: '08721209d18f180afd8906e8e1d774a1cd148398fae1b638f58e049d8ff98bf5',
       i686: '5cb03cfd2bc61e3a8e55200f95a4b834c1253d278c873c5f5af9fdd87fb3eca1',
     x86_64: 'b07d8e5fc001b8d48debb7b46bbc4c44fa03f47bf561a36dcbcd8e9c2fd9bb30',
  })

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
