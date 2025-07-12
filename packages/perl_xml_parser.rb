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
    aarch64: 'afb95f7b13be21bacc36c8d2838b21cb98d10b672fb74b60e616cb6353e17357',
     armv7l: 'afb95f7b13be21bacc36c8d2838b21cb98d10b672fb74b60e616cb6353e17357',
       i686: '5cf25184c1dd75eec775f6494a140ecd742f17e506c12ee79f7cbe5d6d7e8947',
     x86_64: '75ccb2d4c7fa6e6dd0a6f415bb0d72191a91792d9c0b109cdf20f7c5e8000b5e'
  })

  depends_on 'expat' # R
  depends_on 'glibc' # R

  conflicts_ok # conflicts with perl_date_format
end
