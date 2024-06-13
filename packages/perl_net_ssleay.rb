require 'buildsystems/perl'

class Perl_net_ssleay < PERL
  description 'Net::SSLeay - Perl bindings for OpenSSL and LibreSSL'
  homepage 'https://metacpan.org/pod/Net::SSLeay'
  version '1.94-perl5.40'
  license 'BSD'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/C/CH/CHRISN/Net-SSLeay-1.94.tar.gz'
  source_sha256 '9d7be8a56d1bedda05c425306cc504ba134307e0c09bda4a788c98744ebcd95d'
  binary_compression 'tar.zst'

  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'zlibpkg' # R
end
