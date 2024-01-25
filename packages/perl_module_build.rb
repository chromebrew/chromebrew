require 'package'

class Perl_module_build < Package
  description 'Module::Build - Build and install Perl modules'
  homepage 'https://metacpan.org/pod/Module::Build'
  version '0.4234-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/L/LE/LEONT/Module-Build-0.4234.tar.gz'
  source_sha256 '66aeac6127418be5e471ead3744648c766bd01482825c5b66652675f2bc86a8f'
  binary_compression 'tar.zst'

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
