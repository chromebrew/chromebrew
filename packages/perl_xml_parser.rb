require 'buildsystems/perl'

class Perl_xml_parser < PERL
  description 'Perl XML::Parser - A perl module for parsing XML documents'
  homepage 'https://metacpan.org/pod/XML::Parser'
  version "2.59-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-#{version.split('-').first}.tar.gz"
  source_sha256 'a358fd7c49f5e27717a644a9102bd21dc7fc25a415983279c59b1580e2b62a58'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b90327df1006bf82ae3820fec9100a7d1404e12a02ad4997dd898c3ed357cd5d',
     armv7l: 'b90327df1006bf82ae3820fec9100a7d1404e12a02ad4997dd898c3ed357cd5d',
       i686: '490e063606b65d3690d6cb9f10c69ce362396eda51395424d47e1f67ac12caea',
     x86_64: '762d203cfaae1aad93a490019099d55fea76a8f84c48ac3c0bddcbb3f94ba822'
  })

  depends_on 'expat' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'perl' => :logical
  depends_on 'perl_file_sharedir_install' => :build

  conflicts_ok # conflicts with perl_date_format
end
