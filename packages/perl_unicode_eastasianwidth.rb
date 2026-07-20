require 'package'

class Perl_unicode_eastasianwidth < Package
  description 'Perl Unicode::EastAsianWidth - East Asian Width properties.'
  homepage 'https://metacpan.org/pod/Unicode::EastAsianWidth'
  version "12.0-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/A/AU/AUDREYT/Unicode-EastAsianWidth-#{version.split('-').first}.tar.gz"
  source_sha256 '2a5bfd926c4fe5f77e6137da2c31ac2545282ae5fec6e9af0fdd403555a90ff4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '32cebf0adf31cc80686b7b4b3c8b28f41f94482ea5d1abf501a4d6e888681bda',
     armv7l: '32cebf0adf31cc80686b7b4b3c8b28f41f94482ea5d1abf501a4d6e888681bda',
       i686: '1a783f036ae9555ed28c80657a373118d8ce610dc130b7c8d39305d5ded2bb75',
     x86_64: '5c19ea5a346ea597d8209dafbfc1cd71e91894993cb873cc25de02ca2d16fb37'
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
