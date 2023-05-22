require 'package'

class Perl_yaml_tiny < Package
  description 'YAML::Tiny - Read/Write YAML files with as little code as possible'
  homepage 'https://metacpan.org/pod/YAML::Tiny'
  version '1.74-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/YAML-Tiny-1.74.tar.gz'
  source_sha256 '7b38ca9f5d3ce24230a6b8bdc1f47f5b2db348e7f7f9666c26f5955636e33d6c'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_yaml_tiny/1.74-perl5.36_i686/perl_yaml_tiny-1.74-perl5.36-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_yaml_tiny/1.74-perl5.36_x86_64/perl_yaml_tiny-1.74-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: 'ee0b9568bb0df22cad50dc46228c30b7e67680fc66baf516c297d3a6abbbc59d',
  x86_64: '469497afcfcde358f611756859923411181734b82d5d20d2bcbdbca4c1984cc3'
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
