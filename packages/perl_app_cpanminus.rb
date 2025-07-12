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
    aarch64: 'cb18b151e66da219ac9881c84ffb3ddbadaa28e77e30d58a9f01d441e782dace',
     armv7l: 'cb18b151e66da219ac9881c84ffb3ddbadaa28e77e30d58a9f01d441e782dace',
       i686: '71c3ab7c3dd33e588d01ee6857ed0bb49e57f37bcc0bb40522bda023cc9548c4',
     x86_64: '1beebd1257d21c93bf818c7de59bd5bfa10e6920263f2ac2db4adaba8c71040c'
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
