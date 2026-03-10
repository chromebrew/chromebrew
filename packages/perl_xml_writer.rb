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
    aarch64: '8a12779e8bb32fbca3bcaa8a8b2b7f5f1646793aed693930e1a8aa13c6ec2f7e',
     armv7l: '8a12779e8bb32fbca3bcaa8a8b2b7f5f1646793aed693930e1a8aa13c6ec2f7e',
       i686: 'eb28f7ae348ad9d8b260543c6fa6d4d7f9f3d5bb3174652517593bd73e3c12b8',
     x86_64: 'b421c737a37b1237711a9f1d9bd12d1f602f814e797a5db0f5839e67b3f3e596'
  })
end
