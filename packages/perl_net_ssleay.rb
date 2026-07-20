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
    aarch64: 'a1700c04825b19844252c0b14c0729365af6c1819887e4a3b49cccaef97ecab4',
     armv7l: 'a1700c04825b19844252c0b14c0729365af6c1819887e4a3b49cccaef97ecab4',
       i686: '1d67e036312e3913ae17534e0b6e6665b444d8dcc931c95a1b2e8b3033802ac7',
     x86_64: '4a9afbc0887db78f77f87dadd75e7878fc9bafab29bbe9c6dee0d85e636f769b'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :library
  depends_on 'perl' => :logical
  depends_on 'zlib' => :library
end
