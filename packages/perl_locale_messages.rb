require 'package'

class Perl_locale_messages < Package
  description 'Perl Locale::Messages - Gettext Like Message Retrieval'
  homepage 'https://metacpan.org/pod/Locale::Messages'
  version '1.33-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GU/GUIDO/libintl-perl-1.33.tar.gz'
  source_sha256 '5126eda9ccd0eeb10db82ddef63cbcaf7dbd771e78cc0fb110cc3b5a6b8679e7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.33-perl5.38_armv7l/perl_locale_messages-1.33-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.33-perl5.38_armv7l/perl_locale_messages-1.33-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.33-perl5.38_i686/perl_locale_messages-1.33-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.33-perl5.38_x86_64/perl_locale_messages-1.33-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bb362578ef19bde79061dbd1122f1c65c6cda4c88e31e5a1a2356c26d13e10fd',
     armv7l: 'bb362578ef19bde79061dbd1122f1c65c6cda4c88e31e5a1a2356c26d13e10fd',
       i686: 'a40e34c76cc378988bdebae094ea4ff5e8157ae08e631bb952fabe94539b849a',
     x86_64: 'ebe25a0e60cd06c6ce9545a63791381f99b589f846cea037d737115a25b1b3f3'
  })

  depends_on 'glibc' # R

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
