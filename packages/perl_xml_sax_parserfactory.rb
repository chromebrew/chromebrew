require 'package'
require_relative 'perl_xml_sax'

class Perl_xml_sax_parserfactory < Package
  description 'XML::SAX::ParserFactory is a factory class for providing an application with a Perl SAX2 XML parser.'
  homepage 'https://metacpan.org/pod/XML::SAX::ParserFactory'
  version Perl_xml_sax.version
  license 'GPL-1+ or Artistic'
  compatibility 'all'

  is_fake
end
