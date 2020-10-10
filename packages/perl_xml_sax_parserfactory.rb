require 'package'

class Perl_xml_sax_parserfactory < Package
  description 'XML::SAX::ParserFactory is a factory class for providing an application with a Perl SAX2 XML parser.'
  homepage 'https://metacpan.org/source/GRANTM/XML-SAX-0.99/SAX/'
  version '1.02'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-SAX-1.02.tar.gz'
  source_sha256 '4506c387043aa6a77b455f00f57409f3720aa7e553495ab2535263b4ed1ea12a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_sax_parserfactory-1.02-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_sax_parserfactory-1.02-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_sax_parserfactory-1.02-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_sax_parserfactory-1.02-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9a65d90e104f6345618c68a626188de073498c5a836f02478ee0388af74197d2',
     armv7l: '9a65d90e104f6345618c68a626188de073498c5a836f02478ee0388af74197d2',
       i686: 'beaa39f268e11c8b66b12599defed197de773bcc2f9938bdbfcf9696fa198fb4',
     x86_64: '99d8022173ad714e70c9f235264bce34a3a2f1af65269cc929e4d23a0347e66a',
  })

  depends_on 'perl'

  def self.build
  end

  def self.install
    # install files to build directory
    system 'cpanm', '-l', 'build', '--self-contained', '.'

    # install lib
    libdir = CREW_DEST_DIR + `perl -e 'require Config; print $Config::Config{'"'installsitelib'"'};'`
    FileUtils.mkdir_p libdir
    system "(cd build/lib/perl5; tar cf - .) | (cd #{libdir}; tar xfp -)"

    # install man
    FileUtils.mkdir_p CREW_DEST_MAN_PREFIX
    system "(cd build/man; tar cf - .) | (cd #{CREW_DEST_MAN_PREFIX}; tar xfp -)"
  end

  def self.check
  end
end
