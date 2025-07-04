require 'package'

class Perl_date_calc < Package
  description 'Gregorian calendar date calculations'
  homepage 'https://metacpan.org/pod/Date::Calc'
  version "6.4-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/ST/STBEY/Date-Calc-6.4.tar.gz'
  source_sha256 '7ce137b2e797b7c0901f3adf1a05a19343356cd1f04676aa1c56a9f624f859ad'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '85ea878bb054393f3acc0f2f49df959898dc8a3c3aaaff008e1ed626fa579fcb',
     armv7l: '85ea878bb054393f3acc0f2f49df959898dc8a3c3aaaff008e1ed626fa579fcb',
       i686: 'a0b4774af4cab8a973540ce8dc79df9f88dd7ea72368b02758592a0c0cf91712',
     x86_64: '1b070fe262617ac366014ea0f4dc1ca24c3be423051cdd7bad7b6bc455210472'
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
