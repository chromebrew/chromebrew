require 'package'

class Perl_locale_messages < Package
  description 'Perl Locale::Messages - Gettext Like Message Retrieval'
  homepage 'https://metacpan.org/pod/Locale::Messages'
  version '1.33-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GU/GUIDO/libintl-perl-1.33.tar.gz'
  source_sha256 '5126eda9ccd0eeb10db82ddef63cbcaf7dbd771e78cc0fb110cc3b5a6b8679e7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.32_armv7l/perl_locale_messages-1.32-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.32_armv7l/perl_locale_messages-1.32-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.32_i686/perl_locale_messages-1.32-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.32_x86_64/perl_locale_messages-1.32-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2d6426086396e891db101df18b9ac96acd4826946582386b49989054a61d3725',
     armv7l: '2d6426086396e891db101df18b9ac96acd4826946582386b49989054a61d3725',
       i686: '05ca31eeda58be92c2510c96702c0e8d9d9ee39a2ee2452445ca5f27c721a482',
     x86_64: '4708965e84aba6bf3c46f342261b5972c44f5a33bcaf0686c37fe0412324a6f3'
  })

  def self.prebuild
    system 'perl', 'Makefile.PL'
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
