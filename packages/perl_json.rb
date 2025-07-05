# Adapted from Arch Linux perl-json PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/perl-json/trunk/PKGBUILD

require 'package'

class Perl_json < Package
  description 'JSON JavaScript Object Notation encoder/decoder'
  homepage 'https://search.cpan.org/dist/JSON'
  version "4.10-#{CREW_PERL_VER}"
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url 'https://search.cpan.org/CPAN/authors/id/I/IS/ISHIGAKI/JSON-4.10.tar.gz'
  source_sha256 'df8b5143d9a7de99c47b55f1a170bd1f69f711935c186a6dc0ab56dd05758e35'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1b85cf450cc76f4d135de48d85a179c9d01253edb2d4b17df237874a95789300',
     armv7l: '1b85cf450cc76f4d135de48d85a179c9d01253edb2d4b17df237874a95789300',
       i686: '75220a51d8eb0c24153c1b7f5e89f0e09b38256aeaf80ed0afd394df3a24371a',
     x86_64: 'e1346d1375530b6972bdf96eb3d9379f90678cba762c4821b645474eb49ebfe1'
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
