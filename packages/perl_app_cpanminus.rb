require 'package'

class Perl_app_cpanminus < Package
  description 'App::cpanminus - get, unpack, build and install modules from CPAN'
  homepage 'https://metacpan.org/pod/App::cpanminus'
  version "1.7049-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/M/MI/MIYAGAWA/App-cpanminus-#{version.split('-')[0]}.tar.gz"
  source_sha256 '963e63c6e1a8725ff2f624e9086396ae150db51dd0a337c3781d09a994af05a5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '981f4ef3efbd70eb6fbe001aa38930866658885c3cf5784ee27c33f563579adf',
     armv7l: '981f4ef3efbd70eb6fbe001aa38930866658885c3cf5784ee27c33f563579adf',
       i686: '8d1817e4f83354a646aea2c5a80d9ce589a4e9c041d0f21c2dc2b65eb87fec64',
     x86_64: '8fd5dfd2023808ed07ddef9b045c7304aad95e607768ed011bc59156c9a9fbcc'
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
