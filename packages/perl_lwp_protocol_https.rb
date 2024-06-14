require 'buildsystems/perl'

class Perl_lwp_protocol_https < PERL
  description 'Provide https support for LWP::UserAgent'
  homepage 'https://metacpan.org/pod/LWP::Protocol::https'
  version '6.14-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/LWP-Protocol-https-6.14.tar.gz'
  source_sha256 '59cdeabf26950d4f1bef70f096b0d77c5b1c5a7b5ad1b66d71b681ba279cbb2a'
  binary_compression 'tar.zst'

  no_compile_needed
end
