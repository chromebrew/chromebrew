require 'package'

class Perl_date_manip < Package
  description 'Date manipulation routines'
  homepage 'https://metacpan.org/pod/Date::Manip'
  version '6.82-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SB/SBECK/Date-Manip-6.82.tar.gz'
  source_sha256 'fa96bcf94c6b4b7d3333f073f5d0faad59f546e5aec13ac01718f2e6ef14672a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_manip/6.82-1_armv7l/perl_date_manip-6.82-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_manip/6.82-1_armv7l/perl_date_manip-6.82-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_manip/6.82-1_i686/perl_date_manip-6.82-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_manip/6.82-1_x86_64/perl_date_manip-6.82-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '96b6434cacbc4c44472b663f92f8f1f66fa017aade85cf73b589cbc92b0cd988',
     armv7l: '96b6434cacbc4c44472b663f92f8f1f66fa017aade85cf73b589cbc92b0cd988',
       i686: '5d0213058c1d5c1d20eae4223cadde99c563f23a66cd7637553d1c35797bf7df',
     x86_64: 'aac6357483d49208f09ee9b1c71087ca10924ddba8268fbf054fb3efc3ed7a5d'
  })

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
