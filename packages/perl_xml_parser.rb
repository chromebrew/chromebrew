require 'buildsystems/perl'

class Perl_xml_parser < PERL
  description 'Perl XML::Parser - A perl module for parsing XML documents'
  homepage 'https://metacpan.org/pod/XML::Parser'
  version '2.47-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.47.tar.gz'
  source_sha256 'ad4aae643ec784f489b956abe952432871a622d4e2b5c619e8855accbfc4d1d8'
  binary_compression 'tar.zst'

  depends_on 'expat' # R
  depends_on 'glibc' # R

  conflicts_ok # conflicts with perl_date_format
end
