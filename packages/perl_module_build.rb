require 'package'

class Perl_module_build < Package
  description 'Module::Build - Build and install Perl modules'
  homepage 'https://metacpan.org/pod/Module::Build'
  version '0.4234-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/L/LE/LEONT/Module-Build-0.4234.tar.gz'
  source_sha256 '66aeac6127418be5e471ead3744648c766bd01482825c5b66652675f2bc86a8f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_module_build/0.4234-perl5.38_armv7l/perl_module_build-0.4234-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_module_build/0.4234-perl5.38_armv7l/perl_module_build-0.4234-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_module_build/0.4234-perl5.38_i686/perl_module_build-0.4234-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_module_build/0.4234-perl5.38_x86_64/perl_module_build-0.4234-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd1a56769ff3f626329cd4336da679b2e94328a7cd94120e7b3702774d555088e',
     armv7l: 'd1a56769ff3f626329cd4336da679b2e94328a7cd94120e7b3702774d555088e',
       i686: '4215913596d1bdbc1c53f50a621973fa775c12274a34701c2aa3850601868a85',
     x86_64: '9b556725f0f9d358d9bb976e56a794b3db1cf95a3cede5ab8e9c0360a5f65697'
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
