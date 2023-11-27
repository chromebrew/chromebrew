require 'buildsystems/perl'

class Perl_xml_parser < PERL
  description 'Perl XML::Parser - A perl module for parsing XML documents'
  homepage 'https://metacpan.org/pod/XML::Parser'
  version '2.46-perl5.38.1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.46.tar.gz'
  source_sha256 'd331332491c51cccfb4cb94ffc44f9cd73378e618498d4a37df9e043661c515d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-perl5.38.1_armv7l/perl_xml_parser-2.46-perl5.38.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-perl5.38.1_armv7l/perl_xml_parser-2.46-perl5.38.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-perl5.38.1_i686/perl_xml_parser-2.46-perl5.38.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-perl5.38.1_x86_64/perl_xml_parser-2.46-perl5.38.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '88ccca7d9086251d110221235b46f981d1840bbc0842c9bb58ccc16f019b6dee',
     armv7l: '88ccca7d9086251d110221235b46f981d1840bbc0842c9bb58ccc16f019b6dee',
       i686: 'f07408a005c1055d7e9602b15104323e039b5f91df85f0e6e017dd627998395e',
     x86_64: '6ce38db71eab3397edb8b9d16f0c96d95d805fc8173cdabd531164b0b734f54c'
  })

  depends_on 'expat' # R
  depends_on 'glibc' # R

  conflicts_ok # conflicts with perl_date_format
end
