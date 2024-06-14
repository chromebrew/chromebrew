require 'package'

class Perl_app_cpanminus < Package
  description 'App::cpanminus - get, unpack, build and install modules from CPAN'
  homepage 'https://metacpan.org/pod/App::cpanminus'
  version '1.7047-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/M/MI/MIYAGAWA/App-cpanminus-1.7047.tar.gz'
  source_sha256 '963e63c6e1a8725ff2f624e9086396ae150db51dd0a337c3781d09a994af05a5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '84e030ee7dab59b7a923ee81f4783a01da53034fdba1bd9b5341c09b7cb29f88',
     armv7l: '84e030ee7dab59b7a923ee81f4783a01da53034fdba1bd9b5341c09b7cb29f88',
       i686: '0c1b25eeb9a35847965e4f8a36c89fe9b3ae24856e30b36b5c7f44aa2f20938f',
     x86_64: '160ae3c20b576049a20bad272a46f11c0c04436716cb0a04199a7550f5708583'
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
