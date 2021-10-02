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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_parse_yapp/1.22_armv7l/perl_parse_yapp-1.22-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_parse_yapp/1.22_armv7l/perl_parse_yapp-1.22-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_parse_yapp/1.22_i686/perl_parse_yapp-1.22-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_parse_yapp/1.22_x86_64/perl_parse_yapp-1.22-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'cdc7fdd872f79b166421a6fcdcf02d15ef8b5612da90f4d5c6e87c127ad9436d',
     armv7l: 'cdc7fdd872f79b166421a6fcdcf02d15ef8b5612da90f4d5c6e87c127ad9436d',
       i686: 'f44f9ab5cb9b8a71d4ef86e0b2f0e503bdbab015a9ccae86e0a9c34dd30af5bb',
     x86_64: 'bff95a47e92184654a9b1a2caac5b921b92d19c26bc4160a1306b91b5bde1e8c'
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
