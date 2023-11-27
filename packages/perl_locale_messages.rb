require 'buildsystems/perl'

class Perl_locale_messages < PERL
  description 'Perl Locale::Messages - Gettext Like Message Retrieval'
  homepage 'https://metacpan.org/pod/Locale::Messages'
  version '1.33-perl5.38.1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GU/GUIDO/libintl-perl-1.33.tar.gz'
  source_sha256 '5126eda9ccd0eeb10db82ddef63cbcaf7dbd771e78cc0fb110cc3b5a6b8679e7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.33-perl5.38.1_armv7l/perl_locale_messages-1.33-perl5.38.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.33-perl5.38.1_armv7l/perl_locale_messages-1.33-perl5.38.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.33-perl5.38.1_i686/perl_locale_messages-1.33-perl5.38.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.33-perl5.38.1_x86_64/perl_locale_messages-1.33-perl5.38.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '49965477fed0290b6c02f757eac5722368a9ad0ec460741c65b4d5c4f52b58c4',
     armv7l: '49965477fed0290b6c02f757eac5722368a9ad0ec460741c65b4d5c4f52b58c4',
       i686: 'f9993057efa7afce45b4c85489e4b67c60ec00935b622e2a6100d5ae9261aa52',
     x86_64: '523a17ac0a33e74ff5d379d836b3ea1155f8981e2dd5cbe94b3abc81e6d76f8c'
  })

  depends_on 'glibc' # R
end
