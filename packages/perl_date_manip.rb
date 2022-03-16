require 'package'

class Perl_date_manip < Package
  description 'Date::Manip - Date manipulation routines'
  homepage 'https://metacpan.org/pod/Date::Manip'
  version '6.86'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SB/SBECK/Date-Manip-6.86.tar.gz'
  source_sha256 'b5203782d03c79aa5822cf33d1828aaa3b4db93a275d4a428c89f56f4713361f'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_manip/6.86_i686/perl_date_manip-6.86-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_manip/6.86_x86_64/perl_date_manip-6.86-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: '76657f3f2cc037f83597b4ca2d01e8281b86b886365bd12ff2d824323f21fab9',
  x86_64: '12f9ce224833afc565ab0818e6809752d88860f2b3d48a66ea60ab65d62f3e33'
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
