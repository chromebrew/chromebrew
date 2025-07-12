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
    aarch64: 'b5a0f810259b39ac12bca36cade06b64f9eed28ab3a409b757277d9d42392352',
     armv7l: 'b5a0f810259b39ac12bca36cade06b64f9eed28ab3a409b757277d9d42392352',
       i686: '9bc35270312f9ca375b0edc5a7b3a8268ab759d467ad1df1cd67b26f31c2c4db',
     x86_64: '4662a625d61a83f95496221c13ab543975a98343a672bbe16a6e3173dd79ff50'
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
