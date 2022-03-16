require 'package'

class Perl_yaml_tiny < Package
  description 'YAML::Tiny - Read/Write YAML files with as little code as possible'
  homepage 'https://metacpan.org/pod/YAML::Tiny'
  version '1.73-3'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/YAML-Tiny-1.73.tar.gz'
  source_sha256 'bc315fa12e8f1e3ee5e2f430d90b708a5dc7e47c867dba8dce3a6b8fbe257744'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_yaml_tiny/1.73-3_i686/perl_yaml_tiny-1.73-3-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_yaml_tiny/1.73-3_x86_64/perl_yaml_tiny-1.73-3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: '3d237617f73685eaf6ea747b793acbdd52cfdbbe6b20c4eaf0a7c008ede59082',
  x86_64: 'ded5fecb255389c52e7062a426df6b0b6c0beab9631917855941716c5b163fe4'
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
