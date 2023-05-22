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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_json/4.10-perl5.36_armv7l/perl_json-4.10-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_json/4.10-perl5.36_armv7l/perl_json-4.10-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_json/4.10-perl5.36_i686/perl_json-4.10-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_json/4.10-perl5.36_x86_64/perl_json-4.10-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4fcde576679993242705a993ba29547757587feff3c723339ffe58fba1b9668e',
     armv7l: '4fcde576679993242705a993ba29547757587feff3c723339ffe58fba1b9668e',
       i686: '47f94cc795acebd0d640d6c89e04812e992cf337061db6e9ed0a059b8edcdd5c',
     x86_64: '02337554beeee198cdfdaa102b544c8cafd342d0e2391cd0c2789b166f2164f1'
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
