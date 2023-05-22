require 'package'

class Perl_date_calc < Package
  description 'Gregorian calendar date calculations'
  homepage 'https://metacpan.org/pod/Date::Calc'
  version '6.4-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/ST/STBEY/Date-Calc-6.4.tar.gz'
  source_sha256 '7ce137b2e797b7c0901f3adf1a05a19343356cd1f04676aa1c56a9f624f859ad'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_calc/6.4-2_armv7l/perl_date_calc-6.4-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_calc/6.4-2_armv7l/perl_date_calc-6.4-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_calc/6.4-2_i686/perl_date_calc-6.4-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_calc/6.4-2_x86_64/perl_date_calc-6.4-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3dc10029a15f7c6156d435166a96fa1c1412dba99188bf50685a428ee12dae1f',
     armv7l: '3dc10029a15f7c6156d435166a96fa1c1412dba99188bf50685a428ee12dae1f',
       i686: 'f0151fb996a7f559e28bce2b8c823fe5e6059d9668915fcaf74df3b1535a670a',
     x86_64: 'd8b045b14ec0d3be8b6cb03e9dd1565382ce2b07226bcb7fdef48573aa62dcf6'
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
