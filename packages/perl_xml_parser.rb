require 'buildsystems/perl'

class Perl_xml_parser < PERL
  description 'Perl XML::Parser - A perl module for parsing XML documents'
  homepage 'https://metacpan.org/pod/XML::Parser'
  version '2.46-perl5.38.2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.46.tar.gz'
  source_sha256 'd331332491c51cccfb4cb94ffc44f9cd73378e618498d4a37df9e043661c515d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-perl5.38.2_armv7l/perl_xml_parser-2.46-perl5.38.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-perl5.38.2_armv7l/perl_xml_parser-2.46-perl5.38.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-perl5.38.2_i686/perl_xml_parser-2.46-perl5.38.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-perl5.38.2_x86_64/perl_xml_parser-2.46-perl5.38.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '145526882871fa42720440e83ce399115861019371e4078877557f4ab579fd63',
     armv7l: '145526882871fa42720440e83ce399115861019371e4078877557f4ab579fd63',
       i686: '25d4a67d1a2ff7d83f162e09d7fbc9feef5047e1a7b07a8cacb25e3477cb6846',
     x86_64: '152702033e12d4ad0df20d5e13bc4addc1e09f98c2040486174c82944e0ae1a9'
  })

  depends_on 'expat' # R
  depends_on 'glibc' # R

  conflicts_ok # conflicts with perl_date_format
end
