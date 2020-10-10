
require 'package'

class Perl_locale_gettext < Package
  description 'Locale::gettext - message handling functions'
  homepage 'https://metacpan.org/pod/Locale::gettext'
  compatibility 'all'
  version '1.07-1'
  source_url 'https://cpan.metacpan.org/authors/id/P/PV/PVANDRY/gettext-1.07.tar.gz'
  source_sha256 '909d47954697e7c04218f972915b787bd1244d75e3bd01620bc167d5bbc49c15'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_locale_gettext-1.07-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_locale_gettext-1.07-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_locale_gettext-1.07-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_locale_gettext-1.07-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2ca25cdafbe78b4d6b5e01c8985c20a2341c06c3b6969c50fa57f5dda2980e07',
     armv7l: '2ca25cdafbe78b4d6b5e01c8985c20a2341c06c3b6969c50fa57f5dda2980e07',
       i686: 'cf09ba00b54abf698b8c90e08c0de4f99856179551033f81e7984b4f1ae99e8f',
     x86_64: '1183aaa19a065dcc5578276614e4e42f178b76e629d52285f68a12dae87f9232',
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
