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
    aarch64: '42179515a520506c79c3971991cb14ddd9659e8c364623b1cdba183788c65e8a',
     armv7l: '42179515a520506c79c3971991cb14ddd9659e8c364623b1cdba183788c65e8a',
       i686: '4f457937c556a28c66348a606291d27a5b3239310e71c55b2d63eaaf8d716cc3',
     x86_64: 'b46df00838f120aab49439e97339f3846483a3e6b103cca0dd6d101a523fb04f'
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
