require 'buildsystems/perl'

class Perl_locale_messages < PERL
  description 'Perl Locale::Messages - Gettext Like Message Retrieval'
  homepage 'https://metacpan.org/pod/Locale::Messages'
  version "1.35-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GU/GUIDO/libintl-perl-1.33.tar.gz'
  source_sha256 '5126eda9ccd0eeb10db82ddef63cbcaf7dbd771e78cc0fb110cc3b5a6b8679e7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '87e1fa0d5ac612b395f417e7618471e1578bb5397d991c17ec0ee15959639757',
     armv7l: '87e1fa0d5ac612b395f417e7618471e1578bb5397d991c17ec0ee15959639757',
       i686: '2e6f8d3910f967d38c70fc67685f801c948e2d6a399bc32b930a0df9cd15845f',
     x86_64: '1b6f980323c81c44da6ef6ca84ac250ba1ca54dd7e2d51a8f45133dfcf2713fd'
  })

  depends_on 'glibc' # R
end
