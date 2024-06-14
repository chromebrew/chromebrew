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

  binary_sha256({
    aarch64: 'dc513863d63f1a38fd10ef532e0680e7fb52294c682eaee0f8d5cb3100846b39',
     armv7l: 'dc513863d63f1a38fd10ef532e0680e7fb52294c682eaee0f8d5cb3100846b39',
       i686: '32a7f58beaf5e2f5472cae3008af11e3ce0cdb0c7585592f4ed0b7ec4fb29637',
     x86_64: '8cd7897597178becc53b244e501a45e2f632b2c98f166661abe70e183386cbbf'
  })

  depends_on 'expat' # R
  depends_on 'glibc' # R

  conflicts_ok # conflicts with perl_date_format
end
