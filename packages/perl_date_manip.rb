require 'package'

class Perl_date_manip < Package
  description 'Date::Manip - Date manipulation routines'
  homepage 'https://metacpan.org/pod/Date::Manip'
  version '6.91-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SB/SBECK/Date-Manip-6.91.tar.gz'
  source_sha256 '6bd9cb47e82ba91fdba4022ef358149d81e8453f52ca54f49faac2696210c479'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_manip/6.91-perl5.38_armv7l/perl_date_manip-6.91-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_manip/6.91-perl5.38_armv7l/perl_date_manip-6.91-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_manip/6.91-perl5.38_i686/perl_date_manip-6.91-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_manip/6.91-perl5.38_x86_64/perl_date_manip-6.91-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '49b9d145ee254c109e8881866ab01577665438096882854dc33b7c80d97eceb6',
     armv7l: '49b9d145ee254c109e8881866ab01577665438096882854dc33b7c80d97eceb6',
       i686: '86ba8e6a38ef1f73720d17d58cb0376db4d9f33a2c08cf127f0d02eb4f5ce9d6',
     x86_64: 'e56e9ec533996fefa270badf2bb6889d489bc94230a8efdf8f2766421bbfd427'
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
