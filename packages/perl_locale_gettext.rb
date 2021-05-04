require 'package'

class Perl_locale_gettext < Package
  description 'Locale::gettext - message handling functions'
  homepage 'https://metacpan.org/pod/Locale::gettext'
  license 'GPL-1+ or Artistic'
  version '1.07-2'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/P/PV/PVANDRY/gettext-1.07.tar.gz'
  source_sha256 '909d47954697e7c04218f972915b787bd1244d75e3bd01620bc167d5bbc49c15'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-2_armv7l/perl_locale_gettext-1.07-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-2_armv7l/perl_locale_gettext-1.07-2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-2_i686/perl_locale_gettext-1.07-2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_locale_gettext/1.07-2_x86_64/perl_locale_gettext-1.07-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5ba4484084fe099eb2bb9c2db6ac7461fd9b951e41992bc4105cd68ae48094a8',
     armv7l: '5ba4484084fe099eb2bb9c2db6ac7461fd9b951e41992bc4105cd68ae48094a8',
       i686: 'de64c0415d97e2d0f5fd5cc6cee55f55f511d86528442c8b382eb7223214c13f',
     x86_64: '9cf2b992dad51c31253e717dadc1ea3318efa56eb0261958e389d554bb6436b3'
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
