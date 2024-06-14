# Adapted from Arch Linux perl-json PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/perl-json/trunk/PKGBUILD

require 'package'

class Perl_json < Package
  description 'JSON JavaScript Object Notation encoder/decoder'
  homepage 'https://search.cpan.org/dist/JSON'
  version '4.10-perl5.40'
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url 'https://search.cpan.org/CPAN/authors/id/I/IS/ISHIGAKI/JSON-4.10.tar.gz'
  source_sha256 'df8b5143d9a7de99c47b55f1a170bd1f69f711935c186a6dc0ab56dd05758e35'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3e81263eeb6f4e4a1234a7e28e50bac17a450be304fec6a462bd808ec40a19dd',
     armv7l: '3e81263eeb6f4e4a1234a7e28e50bac17a450be304fec6a462bd808ec40a19dd',
       i686: '2869944cfa1331e9aa178d4e237f9626b49fdb0e2c2e609bf91bc6d7293af82b',
     x86_64: '73ac276280d3c8475e317584b45b98c87bdb80214811b65ec66beed62c91c0f7'
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
