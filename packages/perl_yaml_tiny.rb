require 'package'

class Perl_yaml_tiny < Package
  description 'YAML::Tiny - Read/Write YAML files with as little code as possible'
  homepage 'https://metacpan.org/pod/YAML::Tiny'
  version "1.76-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/YAML-Tiny-#{version.split('-')[0]}.tar.gz"
  source_sha256 'a8d584394cf069bf8f17cba3dd5099003b097fce316c31fb094f1b1c171c08a3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ee8963b5e089793465b25b7e1254586a81261e45d08b2ed5a46d7ab602ced1d',
     armv7l: '1ee8963b5e089793465b25b7e1254586a81261e45d08b2ed5a46d7ab602ced1d',
       i686: '2a3b1596f4cec89b7a0f70962e257b3c3b0175f0100a8bc648bc0447ec70f108',
     x86_64: '570b96de7b9675f55ea83d44653a35748b9c3340490dd2236177645dca5208e8'
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
