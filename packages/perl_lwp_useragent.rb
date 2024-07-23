require 'buildsystems/perl'

class Perl_lwp_useragent < PERL
  description 'Web user agent class'
  homepage 'https://metacpan.org/pod/LWP::UserAgent'
  version '6.70-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SI/SIMBABQUE/libwww-perl-6.70.tar.gz'
  source_sha256 '34f00d2344757b9c0b55ad35808d53e93d7d92f7a464ec837fe6a73c51fb5969'
  binary_compression 'tar.zst'

  binary_sha256({
       i686: '435a9347f5bd7c0a2823f904bc9c148cc8636e7a7ee84bf0fc558501f9700c58',
    aarch64: '13086c2a28c90a93273c72a5dac71ea84cb8eae7763f50a445c04cdccc37dc43',
     armv7l: '13086c2a28c90a93273c72a5dac71ea84cb8eae7763f50a445c04cdccc37dc43',
     x86_64: '1ac5b2d0f48946c5b5ead56a55307a278833db4b760ccfdf45837624488c759d'
  })
end
