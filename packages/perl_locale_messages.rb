require 'package'

class Perl_locale_messages < Package
  description 'Perl Locale::Messages - Gettext Like Message Retrieval.'
  homepage 'https://metacpan.org/pod/Locale::Messages'
  version '1.31'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GU/GUIDO/libintl-perl-1.31.tar.gz'
  source_sha256 'cad0b1fd0abfa1340dea089ec45ee3dacd9710c9fd942c064bb8124273b3caa9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_locale_messages-1.31-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_locale_messages-1.31-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_locale_messages-1.31-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_locale_messages-1.31-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'aac0aa6fe8609a8f51f755f738613842dad332d641e3ddbebb30565a82d87be9',
     armv7l: 'aac0aa6fe8609a8f51f755f738613842dad332d641e3ddbebb30565a82d87be9',
       i686: '3f100a08dfb9ef440f75bc5891c6642dbb569c8e404524c497df9f1778dad440',
     x86_64: '11676c56fb5897372398f0ebb4ce8a870757e680ec63dcf7baee6695df53dc52',
  })

  depends_on 'perl'

  def self.build
  end

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

  def self.check
  end
end
