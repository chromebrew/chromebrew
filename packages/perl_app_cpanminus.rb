require 'package'

class Perl_app_cpanminus < Package
  description 'App::cpanminus - get, unpack, build and install modules from CPAN'
  homepage 'https://metacpan.org/pod/App::cpanminus'
  version "1.7047-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/M/MI/MIYAGAWA/App-cpanminus-1.7047.tar.gz'
  source_sha256 '963e63c6e1a8725ff2f624e9086396ae150db51dd0a337c3781d09a994af05a5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'afd83edd920b82ac5f2bfa8426d789bb9d3e6771e8d91b48812d661a6965b381',
     armv7l: 'afd83edd920b82ac5f2bfa8426d789bb9d3e6771e8d91b48812d661a6965b381',
       i686: '78614d5d3acf00ecf08c86e655c498099cab2eee721939da3be66e523f0c70e6',
     x86_64: '18ee4d73b799c9cc7bb2528751fcc3788ecda363f29629c3ddb61df514e51131'
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
