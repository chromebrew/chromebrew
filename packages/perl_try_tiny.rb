require 'buildsystems/perl'

class Perl_try_tiny < PERL
  description 'Minimal try/catch with proper preservation of $@'
  homepage 'https://metacpan.org/pod/Try::Tiny'
  version '0.31-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/Try-Tiny-0.31.tar.gz'
  source_sha256 '3300d31d8a4075b26d8f46ce864a1d913e0e8467ceeba6655d5d2b2e206c11be'
  binary_compression 'tar.zst'

  no_compile_needed
end
