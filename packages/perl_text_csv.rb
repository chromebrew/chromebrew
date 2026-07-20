require 'buildsystems/perl'

class Perl_text_csv < PERL
  description 'Comma-separated values manipulator (using XS or PurePerl)'
  homepage 'https://metacpan.org/pod/Text::CSV'
  version "2.04-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/I/IS/ISHIGAKI/Text-CSV-2.04.tar.gz'
  source_sha256 '4f80122e4ea0b05079cad493e386564030f18c8d7b1f9af561df86985a653fe3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '96fafe3efe806cd8fb903d4a1eddcadb36208b7cb06845b71dcff4e26355d8e2',
     armv7l: '96fafe3efe806cd8fb903d4a1eddcadb36208b7cb06845b71dcff4e26355d8e2',
       i686: '6d358a1dd153a81bae93b0e4ccb5b0055fd8df1083fc8459b85ff50f5a12e681',
     x86_64: '2344726f7e9dbbf45efe7bc28dc7d3cc47913a22f8bc0b7ca098a8091185ed68'
  })

  depends_on 'perl' => :logical
end
