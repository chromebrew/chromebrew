require 'package'

class Perl_yaml_tiny < Package
  description 'YAML::Tiny - Read/Write YAML files with as little code as possible'
  homepage 'https://metacpan.org/pod/YAML::Tiny'
  version "1.74-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/YAML-Tiny-1.74.tar.gz'
  source_sha256 '7b38ca9f5d3ce24230a6b8bdc1f47f5b2db348e7f7f9666c26f5955636e33d6c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b430f947c72edf55c4fd44d8bafda5b11faade319dbdf21e42fdcbadf7dfb9f',
     armv7l: '9b430f947c72edf55c4fd44d8bafda5b11faade319dbdf21e42fdcbadf7dfb9f',
       i686: '9bc35270312f9ca375b0edc5a7b3a8268ab759d467ad1df1cd67b26f31c2c4db',
     x86_64: '532ed529e7c761f9ceac074a0021b09da558b4d758d9d08152157e7cc2e8f6af'
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
