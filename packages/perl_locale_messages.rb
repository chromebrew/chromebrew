require 'buildsystems/perl'

class Perl_locale_messages < PERL
  description 'Perl Locale::Messages - Gettext Like Message Retrieval'
  homepage 'https://metacpan.org/pod/Locale::Messages'
  version '1.33-perl5.38.2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GU/GUIDO/libintl-perl-1.33.tar.gz'
  source_sha256 '5126eda9ccd0eeb10db82ddef63cbcaf7dbd771e78cc0fb110cc3b5a6b8679e7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ba873636a41ff3cca1e0068f1f53dff4e4147b9f0f4c86984067c7db513e9c4',
     armv7l: '1ba873636a41ff3cca1e0068f1f53dff4e4147b9f0f4c86984067c7db513e9c4',
       i686: '85a81cc78b8334f5b09d5f2a4ceded8d988b155ce29e5909c1d80c83b2282674',
     x86_64: 'c952dc68b4e86ee61126d281f13d038eece5c76f9f39cced5bef2c57a4261f65'
  })

  depends_on 'glibc' # R
end
