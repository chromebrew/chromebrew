require 'package'

class Perl_module_build < Package
  description 'Module::Build - Build and install Perl modules'
  homepage 'https://metacpan.org/pod/Module::Build'
  version '0.4231-2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/L/LE/LEONT/Module-Build-0.4231.tar.gz'
  source_sha256 '7e0f4c692c1740c1ac84ea14d7ea3d8bc798b2fb26c09877229e04f430b2b717'

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
