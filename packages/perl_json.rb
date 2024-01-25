# Adapted from Arch Linux perl-json PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/perl-json/trunk/PKGBUILD

require 'package'

class Perl_json < Package
  description 'JSON JavaScript Object Notation encoder/decoder'
  homepage 'https://search.cpan.org/dist/JSON'
  version '4.10-perl5.38'
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url 'https://search.cpan.org/CPAN/authors/id/I/IS/ISHIGAKI/JSON-4.10.tar.gz'
  source_sha256 'df8b5143d9a7de99c47b55f1a170bd1f69f711935c186a6dc0ab56dd05758e35'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bec9c0385bc7436a0df50c7766d0dbe3f98d9a442bd1a9fc882b4c1c13193fd7',
     armv7l: 'bec9c0385bc7436a0df50c7766d0dbe3f98d9a442bd1a9fc882b4c1c13193fd7',
       i686: '15787a74937f015239c659c13003177fbd75d048b0ee683fa72fc49a9af6d1c3',
     x86_64: '20f16a812a40d6197dc995a2869bd2e277efa149567bf4d1635685231eb2411a'
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
