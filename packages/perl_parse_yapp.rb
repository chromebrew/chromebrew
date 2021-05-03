# Adapted from Arch Linux perl-parse-yapp PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/perl-parse-yapp/trunk/PKGBUILD

require 'package'

class Perl_parse_yapp < Package
  description 'Yapp : Generates OO LALR parser modules'
  homepage 'https://search.cpan.org/dist/Parse-Yapp'
  version '1.22'
  license 'GPL'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/W/WB/WBRASWELL/Parse-Yapp-1.21.tar.gz'
  source_sha256 '3810e998308fba2e0f4f26043035032b027ce51ce5c8a52a8b8e340ca65f13e5'

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
