require 'buildsystems/perl'

class Perl_http_date < PERL
  description 'Date conversion routines'
  homepage 'https://metacpan.org/pod/HTTP::Date'
  version '6.06-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/HTTP-Date-6.06.tar.gz'
  source_sha256 '7b685191c6acc3e773d1fc02c95ee1f9fae94f77783175f5e78c181cc92d2b52'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd156e9ad7a193af3bee9278ab562783b9deb872228518fb6e2f72fb56fc2270',
     armv7l: 'bd156e9ad7a193af3bee9278ab562783b9deb872228518fb6e2f72fb56fc2270',
       i686: 'd0f03654f3b4ccf429b9231caa177256e95f40ef022e9c5d8a48e210d0cc10a0',
     x86_64: 'a68944660ce4352060a88b4ef18e2769b3586a01529300059332b36472eeb38a'
  })
end
