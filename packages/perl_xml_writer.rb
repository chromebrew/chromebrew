require 'buildsystems/perl'

class Perl_xml_writer < PERL
  description 'Perl extension for writing XML documents.'
  homepage 'https://metacpan.org/pod/XML::Writer'
  version "0.900-#{CREW_PERL_VER}"
  license 'Copyright (c) 2004-2010 Joseph Walton'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/J/JO/JOSEPHW/XML-Writer-#{version.split('-')[0]}.tar.gz"
  source_sha256 'df8b5143d9a7de99c47b55f1a170bd1f69f711935c186a6dc0ab56dd05758e35'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9cd75f21cf0f45e7caee76b8108365d60ddc0ab878f1ddfcc051c5c7adc5b7a8',
     armv7l: '9cd75f21cf0f45e7caee76b8108365d60ddc0ab878f1ddfcc051c5c7adc5b7a8',
       i686: 'eb28f7ae348ad9d8b260543c6fa6d4d7f9f3d5bb3174652517593bd73e3c12b8',
     x86_64: '21a619197eae95f7a079c37a47fb5045af7aa6be7af695a76e54657c44d43c10'
  })

  depends_on 'perl' => :logical
end
