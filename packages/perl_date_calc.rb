require 'package'

class Perl_date_calc < Package
  description 'Gregorian calendar date calculations'
  homepage 'https://metacpan.org/pod/Date::Calc'
  version '6.4-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/ST/STBEY/Date-Calc-6.4.tar.gz'
  source_sha256 '7ce137b2e797b7c0901f3adf1a05a19343356cd1f04676aa1c56a9f624f859ad'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_calc/6.4-1_armv7l/perl_date_calc-6.4-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_calc/6.4-1_armv7l/perl_date_calc-6.4-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_calc/6.4-1_i686/perl_date_calc-6.4-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_calc/6.4-1_x86_64/perl_date_calc-6.4-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '794fba788fdccc502c07cf8d213e8c4f116658beaa508a0964bbea36ce4d07fb',
     armv7l: '794fba788fdccc502c07cf8d213e8c4f116658beaa508a0964bbea36ce4d07fb',
       i686: 'a1b37b825b42512d796d38486f1d63696c68257a7c0d6f5be1e64784610d3d5d',
     x86_64: 'f91b5551c3b2f7487d9dedec2a910c9a881bed5dbd732d7fe759adfcb843f186'
  })

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
