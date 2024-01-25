require 'package'

class Perl_yaml_tiny < Package
  description 'YAML::Tiny - Read/Write YAML files with as little code as possible'
  homepage 'https://metacpan.org/pod/YAML::Tiny'
  version '1.74-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/YAML-Tiny-1.74.tar.gz'
  source_sha256 '7b38ca9f5d3ce24230a6b8bdc1f47f5b2db348e7f7f9666c26f5955636e33d6c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6fb7de86fffd16de1d37d9c15f4d245151b112d3be92ac7774a7d0ae50784877',
     armv7l: '6fb7de86fffd16de1d37d9c15f4d245151b112d3be92ac7774a7d0ae50784877',
       i686: '4eaf007e549f666c0401ac35c52e24e4e14eafe7d4270c5216bd84cb2554b3fa',
     x86_64: 'a8d52659db50390e5358a8b38e924112b4507604b16e63d120c4ea55c594dec4'
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
