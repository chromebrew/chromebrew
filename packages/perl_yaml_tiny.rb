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
    aarch64: '843dcc510bfb6029e46133e4d3a5580f4a8e39ee232ff3de1ecdd59220ae505a',
     armv7l: '843dcc510bfb6029e46133e4d3a5580f4a8e39ee232ff3de1ecdd59220ae505a',
       i686: '1c8bfca914a68e0ea8a265d8b7c9d20e6572de269622c14a9c79290ff86acaeb',
     x86_64: 'c8130dcd6ce06f910d28b95d9f9ef690b64d6747b23c6267e9447c43b58a02fc'
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
