require 'package'

class Perl_module_build < Package
  description 'Module::Build - Build and install Perl modules'
  homepage 'https://metacpan.org/pod/Module::Build'
  version "0.4234-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/L/LE/LEONT/Module-Build-0.4234.tar.gz'
  source_sha256 '66aeac6127418be5e471ead3744648c766bd01482825c5b66652675f2bc86a8f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0046662004242b377c5f925b284474369aabbf8b00127a722610097509440938',
     armv7l: '0046662004242b377c5f925b284474369aabbf8b00127a722610097509440938',
       i686: '5d4b7a9c901ed4c0866cdec2f550606e6f1e3def17debe8a7e342bf667b82a0e',
     x86_64: 'd6e0eba8b9d3d1e957806279a57a74dac3a3afa5b56a3cbe80a1fa59105b6271'
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
