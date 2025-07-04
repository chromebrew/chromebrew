require 'buildsystems/perl'

class Perl_xml_parser < PERL
  description 'Perl XML::Parser - A perl module for parsing XML documents'
  homepage 'https://metacpan.org/pod/XML::Parser'
  version "2.47-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.47.tar.gz'
  source_sha256 'ad4aae643ec784f489b956abe952432871a622d4e2b5c619e8855accbfc4d1d8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4747268ba7b691dc300acb11769fe4031f6477c463fc29403350c2e65b341530',
     armv7l: '4747268ba7b691dc300acb11769fe4031f6477c463fc29403350c2e65b341530',
       i686: 'bdc42852dc1ba211cf029d55966de13f76a1e4f03b5578d5be7d6960d38dc685',
     x86_64: 'fe15e43d80574ed587e6582058565ece584e96d8e2da06698cda2ba61e0c623c'
  })

  depends_on 'expat' # R
  depends_on 'glibc' # R

  conflicts_ok # conflicts with perl_date_format
end
