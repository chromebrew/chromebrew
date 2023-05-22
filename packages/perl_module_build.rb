require 'package'

class Perl_module_build < Package
  description 'Module::Build - Build and install Perl modules'
  homepage 'https://metacpan.org/pod/Module::Build'
  version '0.4234-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/L/LE/LEONT/Module-Build-0.4234.tar.gz'
  source_sha256 '66aeac6127418be5e471ead3744648c766bd01482825c5b66652675f2bc86a8f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_module_build/0.4234-perl5.36_armv7l/perl_module_build-0.4234-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_module_build/0.4234-perl5.36_armv7l/perl_module_build-0.4234-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_module_build/0.4234-perl5.36_i686/perl_module_build-0.4234-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_module_build/0.4234-perl5.36_x86_64/perl_module_build-0.4234-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '886ff7c14876cb2cc91aae8a21965acf05bed40e2afab4a0b6962b0a04eb257f',
     armv7l: '886ff7c14876cb2cc91aae8a21965acf05bed40e2afab4a0b6962b0a04eb257f',
       i686: '7b2eabd043343e7629a0385f89350e5ab885fa4cfb82a89d833f38a0a0c459e3',
     x86_64: 'ee633a6ba4b52c36486548e5d6f903e2af05dd9dab95146b5b9c028633e53026'
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
