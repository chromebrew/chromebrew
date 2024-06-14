require 'buildsystems/perl'

class Perl_locale_messages < PERL
  description 'Perl Locale::Messages - Gettext Like Message Retrieval'
  homepage 'https://metacpan.org/pod/Locale::Messages'
  version '1.33-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GU/GUIDO/libintl-perl-1.33.tar.gz'
  source_sha256 '5126eda9ccd0eeb10db82ddef63cbcaf7dbd771e78cc0fb110cc3b5a6b8679e7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff088e008cdc967d93286fa262306b19d32bbf6cdb256e068e8fdd511b43a2c4',
     armv7l: 'ff088e008cdc967d93286fa262306b19d32bbf6cdb256e068e8fdd511b43a2c4',
       i686: 'd796d414d2de50d83bd33a776e591d7a99e79f358076eb58dc03a967f4a6fcab',
     x86_64: '2e2fea24b1c4f625d0294198277494f66464d85dbd9d8cbe5c88aba9647fb147'
  })

  depends_on 'glibc' # R
end
