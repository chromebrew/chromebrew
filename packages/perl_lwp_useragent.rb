require 'buildsystems/perl'

class Perl_lwp_useragent < PERL
  description 'Web user agent class'
  homepage 'https://metacpan.org/pod/LWP::UserAgent'
  version "6.70-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SI/SIMBABQUE/libwww-perl-6.70.tar.gz'
  source_sha256 '34f00d2344757b9c0b55ad35808d53e93d7d92f7a464ec837fe6a73c51fb5969'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cbe709dcb00e8cf6a4adfeefe776d5d2b8a7f25ac5db643cb0ad088d40a39fbb',
     armv7l: 'cbe709dcb00e8cf6a4adfeefe776d5d2b8a7f25ac5db643cb0ad088d40a39fbb',
       i686: '5aca63c57d299e353a184e8793ef0aa9a006052b94aead9b283a73f648f7f719',
     x86_64: '28e4153a2bad0ae8a4416e2de4d2db170394c0fe763ec16116faac9c2c6ea97c'
  })
end
