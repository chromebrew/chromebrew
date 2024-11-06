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
    aarch64: 'bb22446077d1c38f3276071791bc17eb4ccd2e0d129dd4a29faeb5c9cf13d297',
     armv7l: 'bb22446077d1c38f3276071791bc17eb4ccd2e0d129dd4a29faeb5c9cf13d297',
       i686: '43f1179ae094c5d7966bdb65eb8c5dafcfd0c42cda059fe6840f3a8541417583',
     x86_64: '7cbcbfa67fa5654b63ddd8614ed00c6d38c29ee249d8fd94ffbceb2b85cc3384'
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
