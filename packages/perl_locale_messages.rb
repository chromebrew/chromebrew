require 'package'

class Perl_locale_messages < Package
  description 'Perl Locale::Messages - Gettext Like Message Retrieval.'
  homepage 'https://metacpan.org/pod/Locale::Messages'
  version '1.31-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GU/GUIDO/libintl-perl-1.31.tar.gz'
  source_sha256 'cad0b1fd0abfa1340dea089ec45ee3dacd9710c9fd942c064bb8124273b3caa9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.31-1_armv7l/perl_locale_messages-1.31-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.31-1_armv7l/perl_locale_messages-1.31-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.31-1_i686/perl_locale_messages-1.31-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_messages/1.31-1_x86_64/perl_locale_messages-1.31-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'fda26b093588628e08bf3f7b4cce646b70ffe7074fc00458af7ee02ddbcc44dd',
     armv7l: 'fda26b093588628e08bf3f7b4cce646b70ffe7074fc00458af7ee02ddbcc44dd',
       i686: 'df20e08e1dfa946e067eb00bff209397d3901d7cec5f115d805d67d3b67b0b9b',
     x86_64: 'c4ff271866c9dab9e707a591157c0fafa7a3230294473a6ee77f17a95bc4b978'
  })

  def self.build; end

  def self.install
    # install files to build directory
    system 'cpanm', '-l', 'build', '--self-contained', '.'

    # install lib
    libdir = CREW_DEST_DIR + `perl -e 'require Config; print $Config::Config{'"'installsitelib'"'};'`
    FileUtils.mkdir_p libdir
    system "(cd build/lib/perl5; tar cf - .) | (cd #{libdir}; tar xfp -)"

    # install man
    FileUtils.mkdir_p CREW_DEST_MAN_PREFIX
    system "(cd build/man; tar cf - .) | (cd #{CREW_DEST_MAN_PREFIX}; tar xfp -)"
  end

  def self.check; end
end
