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

  no_compile_needed
end
