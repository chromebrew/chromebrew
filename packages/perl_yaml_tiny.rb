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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_yaml_tiny/1.74-perl5.36_armv7l/perl_yaml_tiny-1.74-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_yaml_tiny/1.74-perl5.36_armv7l/perl_yaml_tiny-1.74-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_yaml_tiny/1.74-perl5.36_i686/perl_yaml_tiny-1.74-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_yaml_tiny/1.74-perl5.36_x86_64/perl_yaml_tiny-1.74-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8803771c4db5385ae6eddff81d6ef55a78e024927c44139814275a8ce0d1099c',
     armv7l: '8803771c4db5385ae6eddff81d6ef55a78e024927c44139814275a8ce0d1099c',
       i686: 'f8b41f905d949495a5b945d1d9a39fb8613d845a4acab42e050665e6dedfcaf2',
     x86_64: '161e30d9f48bf91dbc4402a3d0566e58c1d747b4a7887521bde715270bc2a51e'
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
