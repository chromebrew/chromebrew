require 'package'

class Perl_date_manip < Package
  description 'Date::Manip - Date manipulation routines'
  homepage 'https://metacpan.org/pod/Date::Manip'
  version '6.91-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SB/SBECK/Date-Manip-6.91.tar.gz'
  source_sha256 '6bd9cb47e82ba91fdba4022ef358149d81e8453f52ca54f49faac2696210c479'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_manip/6.91-perl5.36_armv7l/perl_date_manip-6.91-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_manip/6.91-perl5.36_armv7l/perl_date_manip-6.91-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_manip/6.91-perl5.36_i686/perl_date_manip-6.91-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_manip/6.91-perl5.36_x86_64/perl_date_manip-6.91-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bb494888bca9031449a0f01676e9f3e091d11a92e6a59d69ce594d1f93ef1469',
     armv7l: 'bb494888bca9031449a0f01676e9f3e091d11a92e6a59d69ce594d1f93ef1469',
       i686: '8641f7ec4d130d254c81c6d2401cdd1a945a3e3a5adf06684c737f5d6c956df2',
     x86_64: '415754d100f572be59a2fb0225a8941fc864045e39a7c363c5a0641121b1e187'
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
