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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_calc/6.4-perl5.36_armv7l/perl_date_calc-6.4-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_calc/6.4-perl5.36_armv7l/perl_date_calc-6.4-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_calc/6.4-perl5.36_i686/perl_date_calc-6.4-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_calc/6.4-perl5.36_x86_64/perl_date_calc-6.4-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '73a93c6756a6fdd2beb5fc4144def524355c8d09cbbdfe21b2a337737d510484',
     armv7l: '73a93c6756a6fdd2beb5fc4144def524355c8d09cbbdfe21b2a337737d510484',
       i686: '4406d4a04d000934a88f0b7e49923d01312f5d5d194002a73cec7a17d065b5f2',
     x86_64: '11e737702525fab32b4170dd6179f8ca4c559959d727efc5498bffacb62ed000'
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
