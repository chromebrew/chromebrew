require 'package'

class Perl_xml_sax_parserfactory < Package
  description 'XML::SAX::ParserFactory is a factory class for providing an application with a Perl SAX2 XML parser.'
  homepage 'https://metacpan.org/source/GRANTM/XML-SAX-0.99/SAX/'
  version '0.99'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-SAX-0.99.tar.gz'
  source_sha256 '32b04b8e36b6cc4cfc486de2d859d87af5386dd930f2383c49347050d6f5ad84'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_sax_parserfactory-0.99-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_sax_parserfactory-0.99-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_sax_parserfactory-0.99-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_sax_parserfactory-0.99-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2e6a336ca325eb357f004fa6098be754a0ad12a5a75c2d47d9e8db9029ca45e7',
     armv7l: '2e6a336ca325eb357f004fa6098be754a0ad12a5a75c2d47d9e8db9029ca45e7',
       i686: '422881325203864e4207eb056efcfa5e6424e8338344eb806b192975c28b2d99',
     x86_64: 'a40967f018b01f5463597cc39b0abf07a1053aa551e5b04be2aaec6119894b94',
  })

  depends_on 'perl'

  def self.build
  end

  def self.install
    # install files to build directory
    system 'cpanm', '-l', "build", '--self-contained', '.'

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
