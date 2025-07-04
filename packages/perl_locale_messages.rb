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
    aarch64: '9d795f301a9edaaa6190c3908010c904fda82d616806ca7f83dfdad3a8b76612',
     armv7l: '9d795f301a9edaaa6190c3908010c904fda82d616806ca7f83dfdad3a8b76612',
       i686: '260855f0c9394f9830327e0b6fa129d09695ea34d9d40c2d018d4756d782e474',
     x86_64: 'f505c3f8887176bc80215d5ca47560e2daf21a41298cf58d61b14b589bcb50d1'
  })

  depends_on 'glibc' # R
end
