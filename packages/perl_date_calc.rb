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
    aarch64: '6d35d5dda7e12d5e45e96ae9a889879bf2b85a53036eb2a506e52572d5fcc1d0',
     armv7l: '6d35d5dda7e12d5e45e96ae9a889879bf2b85a53036eb2a506e52572d5fcc1d0',
       i686: '5a74df2cb3af5c839e383c79439a2a4917c4256caadcf0fdb0a414af8952c7c5',
     x86_64: 'fef93e4586a0d47c16d30a03717e7a45b75580168337adc86a1f57906f7c0c4a'
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
