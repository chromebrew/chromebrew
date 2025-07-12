require 'buildsystems/perl'

class Perl_net_ssleay < PERL
  description 'Net::SSLeay - Perl bindings for OpenSSL and LibreSSL'
  homepage 'https://metacpan.org/pod/Net::SSLeay'
  version "1.94-#{CREW_PERL_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/C/CH/CHRISN/Net-SSLeay-1.94.tar.gz'
  source_sha256 '9d7be8a56d1bedda05c425306cc504ba134307e0c09bda4a788c98744ebcd95d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d510fc2d0eb7816e741e47e696b2218e16754d383c2c607f6010cf0758fa03c',
     armv7l: '1d510fc2d0eb7816e741e47e696b2218e16754d383c2c607f6010cf0758fa03c',
       i686: '7cbad41663426fca56ab36e820d5b9c33f0d77f8e515502ca3f2d99f741a8645',
     x86_64: '8c66f6eef0739412a7d5b66224059ee57b650d8653eb06667b69650befc74925'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'zlib' # R
end
