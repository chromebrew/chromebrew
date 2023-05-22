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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_module_build/0.4231-2_armv7l/perl_module_build-0.4231-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_module_build/0.4231-2_armv7l/perl_module_build-0.4231-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_module_build/0.4231-2_i686/perl_module_build-0.4231-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_module_build/0.4231-2_x86_64/perl_module_build-0.4231-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1d18315cd8eaa350e3b7348b8396348cd31ff880b2d22c657b4fa06811874507',
     armv7l: '1d18315cd8eaa350e3b7348b8396348cd31ff880b2d22c657b4fa06811874507',
       i686: '9060e0b4fc75e4285ad0f576c41c001538036af5f4d9f85778f2d77c73f5dc42',
     x86_64: '5b0e542f3d7e05657ae7edf082cb6ed904310d211f997f7b2f976d0d97c0ae14'
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
