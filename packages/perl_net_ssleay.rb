require 'buildsystems/perl'

class Perl_net_ssleay < PERL
  description 'Net::SSLeay - Perl bindings for OpenSSL and LibreSSL'
  homepage 'https://metacpan.org/pod/Net::SSLeay'
  version "1.96-#{CREW_PERL_VER}"
  license 'BSD'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/C/CH/CHRISN/Net-SSLeay-#{version.split('-')[0]}.tar.gz"
  source_sha256 'ab213691685fb2a576c669cbc8d9266f8165a31563ad15b7c4030b94adfc0753'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4ec8ba7d6c6a73b053ab5da26432e49c0d87f5aa99b034a2b7fe39b0bef5bc19',
     armv7l: '4ec8ba7d6c6a73b053ab5da26432e49c0d87f5aa99b034a2b7fe39b0bef5bc19',
       i686: '9b12bfdb7d46f8b06bcb1a10ac61c6de2fc7ce48743b152a4e4a346ab287b0d2',
     x86_64: 'a9a9debb3415533da9efde1878b17b5c311eeafd58b4812e8a0bc65fa5fc4167'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :library
  depends_on 'perl' => :logical
  depends_on 'zlib' => :library
end
