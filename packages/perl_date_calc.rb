require 'package'

class Perl_date_calc < Package
  description 'Gregorian calendar date calculations'
  homepage 'https://metacpan.org/pod/Date::Calc'
  version '6.4-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/ST/STBEY/Date-Calc-6.4.tar.gz'
  source_sha256 '7ce137b2e797b7c0901f3adf1a05a19343356cd1f04676aa1c56a9f624f859ad'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_calc/6.4-perl5.38_armv7l/perl_date_calc-6.4-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_calc/6.4-perl5.38_armv7l/perl_date_calc-6.4-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_calc/6.4-perl5.38_i686/perl_date_calc-6.4-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_calc/6.4-perl5.38_x86_64/perl_date_calc-6.4-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5a8827b635ec9b38bc91b9278257a01f88ce4f56acc2e1cecbe03e736d7f12c4',
     armv7l: '5a8827b635ec9b38bc91b9278257a01f88ce4f56acc2e1cecbe03e736d7f12c4',
       i686: '4bd7b36ebb15dcb49f17cb56e07dd72088029e835d4c9875d30ae3e34c07c98b',
     x86_64: 'ef04d9b0688554831e413cf35dbb4e92f9681990d569afdbec841dc39866f252'
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
