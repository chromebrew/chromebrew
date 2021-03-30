# Adapted from Arch Linux perl-parse-yapp PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/perl-parse-yapp/trunk/PKGBUILD

require 'package'

class Perl_parse_yapp < Package
  description 'Yapp : Generates OO LALR parser modules'
  homepage 'https://search.cpan.org/dist/Parse-Yapp'
  version '1.21'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/W/WB/WBRASWELL/Parse-Yapp-1.21.tar.gz'
  source_sha256 '3810e998308fba2e0f4f26043035032b027ce51ce5c8a52a8b8e340ca65f13e5'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_parse_yapp-1.21-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_parse_yapp-1.21-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_parse_yapp-1.21-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_parse_yapp-1.21-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6dbd2557641720a8abec288558c7e6708d4d9290c51db08dfcdf53eaeac2728b',
     armv7l: '6dbd2557641720a8abec288558c7e6708d4d9290c51db08dfcdf53eaeac2728b',
       i686: '505658a64ea424427c82cc07774f4a4cca4e03f743c8f8d9fc381ea4d8e67c8e',
     x86_64: 'f0eead5040028f8beecee109a774f413e2abc4c5e55e0441e22d9a3c238146f5'
  })

  def self.install
    # install files to build directory
    system 'cpanm', '-l', 'build', '--self-contained', '--force', '.'

    # install bin
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp 'build/bin/yapp', "#{CREW_DEST_PREFIX}/bin/"

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
