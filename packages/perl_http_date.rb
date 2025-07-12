require 'buildsystems/perl'

class Perl_http_date < PERL
  description 'Date conversion routines'
  homepage 'https://metacpan.org/pod/HTTP::Date'
  version "6.06-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/HTTP-Date-6.06.tar.gz'
  source_sha256 '7b685191c6acc3e773d1fc02c95ee1f9fae94f77783175f5e78c181cc92d2b52'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f7dfe98c25431054e390859c7a95f8f0694f93dfe5e31124355c648646e9791',
     armv7l: '4f7dfe98c25431054e390859c7a95f8f0694f93dfe5e31124355c648646e9791',
       i686: 'f7d7b969432d8348be5d1e33e7db483745e9ec525e01ccb666e88498393ae863',
     x86_64: '58c5021c22135ecc1d2c17662a4bfcecc4726082ad09419820e9e871efb84235'
  })
end
