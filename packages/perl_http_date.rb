require 'buildsystems/perl'

class Perl_http_date < PERL
  description 'Date conversion routines'
  homepage 'https://metacpan.org/pod/HTTP::Date'
  version '6.06-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/HTTP-Date-6.06.tar.gz'
  source_sha256 '7b685191c6acc3e773d1fc02c95ee1f9fae94f77783175f5e78c181cc92d2b52'
  binary_compression 'tar.zst'

  no_compile_needed
end
