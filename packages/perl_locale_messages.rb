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
       i686: 'a727597ee20ab126db4c6a9359b46ea7dd07d975d2bac012fa2a2d8512f4a394',
     x86_64: '16edd446e87f1d783bec912a953de1a2e2b5ce8e2e839f335aa0010989487fdc'
  })

  depends_on 'glibc' # R
end
