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

  binary_sha256({
    aarch64: '78e3f56bf6165a48aee9413ab4c41c8a9794c7abcace92965616d2278ec39aff',
     armv7l: '78e3f56bf6165a48aee9413ab4c41c8a9794c7abcace92965616d2278ec39aff',
       i686: '8857c402d13862c0550cc12260774b6e451a12cd8dbf5a8d07af2b1bd1a01ac5',
     x86_64: '97437a8e5fdd792c35e0b7c90cc55b230a653287fdbd7904ba37af0df4c73cca'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'zlib' # R
end
