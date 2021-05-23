require 'package'

class Perl_xml_sax_parserfactory < Package
  description 'XML::SAX::ParserFactory is a factory class for providing an application with a Perl SAX2 XML parser.'
  homepage 'https://metacpan.org/source/GRANTM/XML-SAX-0.99/SAX/'
  version '1.02-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-SAX-1.02.tar.gz'
  source_sha256 '4506c387043aa6a77b455f00f57409f3720aa7e553495ab2535263b4ed1ea12a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax_parserfactory/1.02-1_armv7l/perl_xml_sax_parserfactory-1.02-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax_parserfactory/1.02-1_armv7l/perl_xml_sax_parserfactory-1.02-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax_parserfactory/1.02-1_i686/perl_xml_sax_parserfactory-1.02-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax_parserfactory/1.02-1_x86_64/perl_xml_sax_parserfactory-1.02-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '8ea748d73c2228eab13bc2d50b1cf920e73e45ca4f68063b8e1aaee232bb0725',
     armv7l: '8ea748d73c2228eab13bc2d50b1cf920e73e45ca4f68063b8e1aaee232bb0725',
       i686: '606e6b8bb6f39207b06f372b9f2b5e0570b32bf43e74fb3591337fd5587d963b',
     x86_64: 'c4cd67e75427b61962ede81353888fe8cf13fb974803562ba541c1fff13a38bd'
  })

  def self.build; end

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

  def self.check; end
end
