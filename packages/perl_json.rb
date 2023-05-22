# Adapted from Arch Linux perl-json PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/perl-json/trunk/PKGBUILD

require 'package'

class Perl_json < Package
  description 'JSON JavaScript Object Notation encoder/decoder'
  homepage 'https://search.cpan.org/dist/JSON'
  version '4.10-perl5.36'
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url 'https://search.cpan.org/CPAN/authors/id/I/IS/ISHIGAKI/JSON-4.10.tar.gz'
  source_sha256 'df8b5143d9a7de99c47b55f1a170bd1f69f711935c186a6dc0ab56dd05758e35'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_json/4.05_armv7l/perl_json-4.05-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_json/4.05_armv7l/perl_json-4.05-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_json/4.05_i686/perl_json-4.05-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_json/4.05_x86_64/perl_json-4.05-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '30e90a27223c850822f6f738d491091b3caf2b472bf07e57927736bf24f16d70',
     armv7l: '30e90a27223c850822f6f738d491091b3caf2b472bf07e57927736bf24f16d70',
       i686: 'd338da27af6830628bfa65922d6a608e87430f1bab7a055a926b0d6edb47bbb5',
     x86_64: '87cde104a0c49bea5dee8dbda9faef3a00354a5fe5f0d0233d3e25e2eb18b47a'
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
